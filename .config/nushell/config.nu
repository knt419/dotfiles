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
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
alias l = ls
alias ll = ls -l
$env.config = {
  shell_integration: {
        # osc2 abbreviates the path if in the home_dir, sets the tab/window title, shows the running command in the tab/window title
        osc2: false
        # osc7 is a way to communicate the path to the terminal, this is helpful for spawning new tabs in the same directory
        osc7: false
        # osc8 is also implemented as the deprecated setting ls.show_clickable_links, it shows clickable links in ls output if your terminal supports it. show_clickable_links is deprecated in favor of osc8
        osc8: false
        # osc9_9 is from ConEmu and is starting to get wider support. It's similar to osc7 in that it communicates the path to the terminal
        osc9_9: false
        # osc133 is several escapes invented by Final Term which include the supported ones below.
        # 133;A - Mark prompt start
        # 133;B - Mark prompt end
        # 133;C - Mark pre-execution
        # 133;D;exit - Mark execution finished with exit code
        # This is used to enable terminals to know where the prompt is, the command is, where the command finishes, and where the output of the command is
        osc133: false
        # osc633 is closely related to osc133 but only exists in visual studio code (vscode) and supports their shell integration features
        # 633;A - Mark prompt start
        # 633;B - Mark prompt end
        # 633;C - Mark pre-execution
        # 633;D;exit - Mark execution finished with exit code
        # 633;E - NOT IMPLEMENTED - Explicitly set the command line with an optional nonce
        # 633;P;Cwd=<path> - Mark the current working directory and communicate it to the terminal
        # and also helps with the run recent menu in vscode
        osc633: false
        # reset_application_mode is escape \x1b[?1l and was added to help ssh work better
        reset_application_mode: false
    }
}

if ("WSL_DISTRO_NAME" in ($env | columns)) {
    $env.GALLIUM_DRIVER = "d3d12"
    $env.MESA_LOADER_DRIVER_OVERRIDE = "d3d12"
    let sock = $"($env.HOME)/.ssh/agent.sock"
    $env.SSH_AUTH_SOCK = $sock

    let ssh_ok = (ssh-add -l | complete)

    if $ssh_ok.exit_code != 0 {
        rm -f $sock
        ^ssh-agent -a $sock | ignore
        ssh-add $"($env.HOME)/.ssh/id_ed25519"
    }
}

if (not ($env | get -o PREFIX | is-empty) and ($env.PREFIX | str contains "com.termux")) {
    let sock = $"($env.HOME)/.ssh/agent.sock"
    $env.SSH_AUTH_SOCK = $sock

    let active_agents = (ps | where name =~ "ssh-agent")

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

def --env yy [] {
    let tmp = (mktemp)

    yazi --cwd-file $tmp

    let cwd = (
        try {
            open $tmp
        } catch {
            ""
        }
    )

    if ($cwd | is-not-empty) and ($cwd != $env.PWD) {
        cd $cwd
    }

    rm -f $tmp
}

def --env smart-right [] {
    let dirs = (
        ls
        | where type == dir
        | sort-by name
    )

    let count = ($dirs | length)

    if $count == 0 {
        return
    }

    if $count == 1 {
        cd ($dirs.0.name)
        return
    }

    yy
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
      commandline set-cursor ((commandline get-cursor) - 1)
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
        ls
        | sort-by type name
        | select name type size modified
    }
}


$env.config.keybindings ++= [
    {
      name: clear_current_prompt
      modifier: none
      keycode: esc
      mode: [emacs, vi_insert, vi_normal]
      event: {
        send: executehostcommand
        cmd: "esc-handler"
        }
    }
    {
        name: smart-left
        modifier: none
        keycode: left
        mode: [emacs vi_normal vi_insert]
        event: {
              send: executehostcommand
              cmd: "left-handler"
        }
    }
    {
        name: smart-right
        modifier: none
        keycode: right
        mode: [emacs vi_normal vi_insert]
        event: {
            until: [
                { send: historyhintcomplete }
                { send: executehostcommand
                  cmd: "right-handler" }
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
            { send: executehostcommand
              cmd: "down-handler" }
            ]
        }
    }
]

cd $env.Home
