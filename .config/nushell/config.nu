# config.nu
#
# Installed by:
# version = "0.104.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.
mkdir ($nu.data-dir | path join "vendor/autoload")
let autoload = ($nu.data-dir | path join "vendor/autoload")

# starship（Omarchy/Windows 共通。条件分岐の外で毎回生成）
^starship init nu | save -f ($autoload | path join "starship.nu")

# --- zoxide / mise（Omarchy のときだけ有効化） --------------------------------
# コード自体は OS 非依存。Windows でも使いたい場合は下の if を外すだけでよい。
# 生成ファイルが無い / ツール本体より古いときだけ作り直す（毎回の外部呼び出しを回避）。
if (($env.IS_OMARCHY? | default false) == true) {
    # cd の代わりに z / zi（bash 側 alias cd=zd に相当）
    if (which zoxide | is-not-empty) {
        let bin = (which zoxide | get 0.path)
        let out = ($autoload | path join "zoxide.nu")
        if (not ($out | path exists)) or ((ls $bin | get 0.modified) > (ls $out | get 0.modified)) {
            ^zoxide init nushell | save -f $out
        }
    }

    # ディレクトリごとのツール版切替（bash 側 mise activate に相当）
    if (which mise | is-not-empty) {
        let bin = (which mise | get 0.path)
        let out = ($autoload | path join "mise.nu")
        if (not ($out | path exists)) or ((ls $bin | get 0.modified) > (ls $out | get 0.modified)) {
            ^mise activate nu | save -f $out
        }
    }
}
alias l = ls
alias la = ls -a
alias ll = ls -l
alias q = exit

# n [path...] → nvim（引数なしなら nvim .）。bash 側の n() と同じ
# --wrapped が無いと `n --version` や `n -o a b` のような nvim のフラグが通らない
def --env --wrapped n [...args: string] {
    if ($args | is-empty) { ^nvim . } else { ^nvim ...$args }
}
$env.LANG = "ja_JP.UTF-8"
# WezTerm は独自の shell integration を持ち nushell 側と競合するため、WezTerm の
# ときだけ全て無効化する。それ以外 (Ghostty など) は nushell の既定値を有効にする。
# WezTerm ships its own shell integration that conflicts with nushell's, so
# disable all of it there; elsewhere (Ghostty, ...) keep nushell's defaults on.
let wezterm = (($env.TERM_PROGRAM? | default "" | str lowercase) == "wezterm")

$env.config = {
    shell_integration: {
        # osc2 abbreviates the path if in the home_dir, sets the tab/window title, shows the running command in the tab/window title
        osc2: (not $wezterm)
        # osc7 is a way to communicate the path to the terminal, this is helpful for spawning new tabs in the same directory
        osc7: (not $wezterm)
        # osc8 is also implemented as the deprecated setting ls.show_clickable_links, it shows clickable links in ls output if your terminal supports it. show_clickable_links is deprecated in favor of osc8
        osc8: (not $wezterm)
        # osc9_9 is from ConEmu and is starting to get wider support. It's similar to osc7 in that it communicates the path to the terminal
        osc9_9: false
        # osc133 is several escapes invented by Final Term which include the supported ones below.
        # 133;A - Mark prompt start
        # 133;B - Mark prompt end
        # 133;C - Mark pre-execution
        # 133;D;exit - Mark execution finished with exit code
        # This is used to enable terminals to know where the prompt is, the command is, where the command finishes, and where the output of the command is
        osc133: (not $wezterm)
        # osc633 is closely related to osc133 but only exists in visual studio code (vscode) and supports their shell integration features
        # 633;A - Mark prompt start
        # 633;B - Mark prompt end
        # 633;C - Mark pre-execution
        # 633;D;exit - Mark execution finished with exit code
        # 633;E - NOT IMPLEMENTED - Explicitly set the command line with an optional nonce
        # 633;P;Cwd=<path> - Mark the current working directory and communicate it to the terminal
        # and also helps with the run recent menu in vscode
        osc633: (not $wezterm)
        # reset_application_mode is escape \x1b[?1l and was added to help ssh work better
        reset_application_mode: (not $wezterm)
    }
}

if "WSL_DISTRO_NAME" in ($env | columns) {
    $env.GALLIUM_DRIVER = "d3d12"
    $env.MESA_LOADER_DRIVER_OVERRIDE = "d3d12"
    let sock = $"($env.HOME)/.ssh/agent.sock"
    $env.SSH_AUTH_SOCK = $sock

    let ssh_ok = ssh-add -l | complete

    if $ssh_ok.exit_code != 0 {
        rm -f $sock
        ^ssh-agent -a $sock | ignore
        ssh-add $"($env.HOME)/.ssh/id_ed25519"
    }
}

if not ($env | get -o PREFIX | is-empty) and ($env.PREFIX | str contains "com.termux") {
    let sock = $"($env.HOME)/.ssh/agent.sock"
    $env.SSH_AUTH_SOCK = $sock

    let active_agents = ps | where name =~ "ssh-agent"

    if ($active_agents | is-empty) {
        rm -f $sock
        ^ssh-agent -a $sock | ignore
        ssh-add $"($env.HOME)/.ssh/id_ed25519"
    }
}

def --env y [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    ^yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    if $cwd != $env.PWD and ($cwd | path exists) {
        cd $cwd
    }
    rm -fp $tmp
}

def --env smart-right [] {
    let dirs = (
        ls
        | where type == dir
        | sort-by name
    )

    let count = $dirs | length

    if $count == 0 {
        return
    }

    if $count == 1 {
        cd ($dirs.0.name)
        return
    }

    y
}

def --env esc-handler [] {
    if (commandline get-cursor) == 0 {
        commandline edit --replace ""
    } else {
        commandline set-cursor 0
    }
}

def --env left-handler [] {
    if (commandline | is-empty) {
        cd ..
    } else {
        let cursor = (commandline get-cursor)
        if $cursor > 0 {
            commandline set-cursor ($cursor - 1)
        }
    }
}

def --env right-handler [] {
    if (commandline | is-empty) {
        smart-right
    } else {
        commandline set-cursor ((commandline get-cursor) + 1)
    }
}

def down-handler [] {
    if (commandline | is-empty) {
        print ""

        let listing = (
                ls
                | sort-by type name
                | select name type size modified
                | table
        )

        print $listing
        print ""
    }
}

$env.config.keybindings ++= [
    {
        name: clear_current_prompt
        modifier: none
        keycode: esc
        mode: [emacs, vi_insert, vi_normal]
        event: {send: executehostcommand, cmd: "esc-handler"}
    }
    {
        name: smart-left
        modifier: none
        keycode: left
        mode: [emacs vi_normal vi_insert]
        event: {send: executehostcommand, cmd: "left-handler"}
    }
    {
        name: smart-right
        modifier: none
        keycode: right
        mode: [emacs vi_normal vi_insert]
        event: {
            until: [
                {send: historyhintcomplete}
                {send: executehostcommand, cmd: "right-handler"}
            ]
        }
    }
    {
        name: smart-down
        modifier: none
        keycode: down
        mode: [emacs vi_normal vi_insert]
        event: {
            until: [
                {send: executehostcommand, cmd: "down-handler"}
            ]
        }
    }
]

cd $nu.home-dir
