# =============================================================================
# env.nu — 対話・非対話どちらの起動でも最初に読まれる。PATH と環境変数だけを置く。
# =============================================================================
$env.VISUAL = 'nvim'
$env.EDITOR = 'nvim'

# --- Omarchy (Arch Linux) 判定 ------------------------------------------------
# OMARCHY_PATH が入っている、または env-bootstrap が存在すれば Omarchy。
# Windows では両方 false になり、下の Omarchy 専用ブロックは丸ごとスキップされる。
let omarchy = ((($env.OMARCHY_PATH? | default '') | is-not-empty)
    or ('/usr/share/omarchy/default/bash/env-bootstrap' | path exists))
$env.IS_OMARCHY = $omarchy

# --- PATH: cargo (OS 非依存) --------------------------------------------------
let cargo_bin = ($nu.home-dir | path join '.cargo' 'bin')
if ($cargo_bin | path exists) and not ($env.PATH | any {|p| $p == $cargo_bin }) {
    $env.PATH = $env.PATH | append $cargo_bin
}

# --- PATH: Omarchy の env-bootstrap 相当（mise のラッパを最優先にする） --------
if $omarchy {
    let mise_dir = ($env.MISE_DATA_DIR?
        | default (($env.XDG_DATA_HOME?
            | default ($nu.home-dir | path join '.local' 'share')) | path join 'mise'))
    let wrappers = ($mise_dir | path join 'command-wrappers' 'bin')
    let shims = ($mise_dir | path join 'shims')
    let local_bin = ($nu.home-dir | path join '.local' 'bin')

    $env.PATH = ([$wrappers]
        ++ ($env.PATH | where {|p| $p != $wrappers })
        | append $shims
        | append $local_bin
        | uniq)
}

# --- 環境変数: Omarchy の bash envs 相当 --------------------------------------
# bash 側 (omarchy/default/bash/envs) と同じ値。Windows には存在しない概念なので
# Omarchy 限定にしている。
if $omarchy {
    $env.SUDO_EDITOR = $env.EDITOR
    $env.BROWSER = 'omarchy-launch-browser'
    $env.BAT_THEME = 'ansi'

    # man ページを bat で色付け
    $env.MANROFFOPT = '-c'
    $env.MANPAGER = "sh -c 'col -bx | bat -l man -p'"
}
