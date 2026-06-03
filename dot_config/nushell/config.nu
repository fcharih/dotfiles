# config.nu
#
# Installed by:
# version = "0.105.1"
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

print " /\\_/\\   DO IT FOR  /\\_/\\"
print "( o.o )  ROSIE AND ( o.o )"
print " > ^ <   TESSIE.    > ^ <"
print " Meow!              Meow!"

$env.config.show_banner = false

let $current_os = if ("Linux" in (sys host).long_os_version) { "Linux" } else { "macOS" }

use std/util "path add"

path add $"($nu.home-path)/.local/bin"
path add "/usr/local/go/bin"
path add $"($nu.home-path)/.environment/commands"
path add $"($nu.home-path)/.environment/commands/nuvobio"
path add $"($nu.home-path)/.pyenv/shims"
path add $"($nu.home-path)/.config/emacs/bin"

let $brew_path = if ($current_os == "macOS" ) { "/opt/homebrew/bin" } else { "/home/linuxbrew/.linuxbrew/bin" }
path add $brew_path

path add $"($nu.home-path)/.cargo/bin"

mkdir ($nu.data-dir | path join "vendor/autoload")
~/.cargo/bin/starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

$env.EDITOR = "lvim"


$env.PYENV_ROOT = "~/.pyenv" | path expand
if (( $"($env.PYENV_ROOT)/bin" | path type ) == "dir") {
  $env.PATH = $env.PATH | prepend $"($env.PYENV_ROOT)/bin" }
$env.PATH = $env.PATH | prepend $"(pyenv root)/shims"

$env.PYTHONPATH = $"($nu.home-path)/.environment/python"

# ALIASES
alias n = lvim
alias z = zellij
alias nopen = open
alias open = ^open
alias cutunnel = ssh -D 8888 -C -N dna-28

# NUSHELL SCRIPTS
source $"($nu.home-path)/.config/nushell/ssh-completion.nu"


const NU_PLUGIN_DIRS = [
  ($nu.current-exe | path dirname)
  ...$NU_PLUGIN_DIRS
]
