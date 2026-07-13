# ~/.config/nushell/config.nu
# Nushell equivalent of the aliases / init-hooks portion of your zshrc.
 
# ---------- One-time setup (run once in a terminal, not on every startup) ----------
# Starship and mise generate nu-native init scripts and drop them in nushell's
# autoload folder, so - unlike zsh - you don't need to `eval` or `source`
# them on every launch. Run these once (and again after upgrading either tool):
#
#   mkdir ($nu.data-dir | path join "vendor/autoload")
#   starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
#   mise activate nu | save -f ($nu.data-dir | path join "vendor/autoload/mise.nu")
#
print " /\\_/\\   DO IT FOR  /\\_/\\"
print "( o.o )  ROSIE AND ( o.o )"
print " > ^ <   TESSIE.    > ^ <"
print " Meow!              Meow!"

$env.config.show_banner = false

let $current_os = if ("Linux" in (sys host).long_os_version) { "Linux" } else { "macOS" }

use std/util "path add"

path add $"($nu.home-path)/.local/bin"
path add $"($nu.home-path)/.cargo/bin"
path add "/usr/local/go/bin"
path add $"($nu.home-path)/.environment/commands"
path add $"($nu.home-path)/.environment/commands/nuvobio"
path add $"($nu.home-path)/.config/emacs/bin"

mkdir ($nu.data-dir | path join "vendor/autoload")
~/.cargo/bin/starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

$env.EDITOR = "nvim"
 
# ---------- Aliases ----------
alias vim = nvim
alias rsync = rsync --progress -v
alias nix-update = nix run home-manager/master -- switch --flake ~/.config/home-manager -b backup
 
# `oplogin` relied on `eval "$(op signin)"` to pick up exported vars.
# Nushell has no generic eval-into-environment, so parse the export lines:
def --env oplogin [] {
    for line in (^op signin | lines) {
        if ($line | str starts-with "export ") {
            let kv = ($line | str replace "export " "" | split row "=")
            load-env {($kv.0): ($kv.1 | str trim -c '"')}
        }
    }
}
 
## `azlogin` / `azcopylogin` as functions, so $env.AZURE_* is read at call
## time rather than baked in once at shell startup like the zsh aliases were.
def azlogin [] {
    az login --service-principal -u $env.AZURE_CLIENT_ID -p $env.AZURE_CLIENT_SECRET --tenant $env.AZURE_TENANT_ID
}
 
def azcopylogin [] {
    with-env {AZCOPY_SPA_CLIENT_SECRET: $env.AZURE_CLIENT_SECRET} {
        azcopy login --service-principal --application-id $env.AZURE_CLIENT_ID --tenant-id $env.AZURE_TENANT_ID
    }
}
#
## ---------- ssh-agent ----------
## `eval "$(ssh-agent -s)"` - parse ssh-agent's export lines into $env.
def --env start-ssh-agent [] {
    for line in (^ssh-agent -s | lines) {
        if ($line | str starts-with "SSH_AUTH_SOCK=") or ($line | str starts-with "SSH_AGENT_PID=") {
            let kv = ($line | split row ";" | first | split row "=")
            load-env {($kv.0): ($kv.1)}
        }
    }
}
start-ssh-agent
 
## Add private keys found under ~/.ssh containing "PRIVATE"
^grep -slR "PRIVATE" ~/.ssh/ | ^xargs ssh-add -q

const NU_PLUGIN_DIRS = [
  ($nu.current-exe | path dirname)
  ...$NU_PLUGIN_DIRS
]

## NUSHELL SCRIPTS
source $"($nu.home-path)/.config/nushell/ssh-completion.nu"
#
## Use mise for python, rust, node, etc.
use "/Users/fcharih/Library/Application Support/nushell/scripts/mise.nu"


