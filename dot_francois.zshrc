# Global
export EDITOR=nvim
export TERM=xterm-256color

# Environment variables
for f in $HOME/.tokens/*; do source "$f"; done

export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.environment/commands
export PATH=$PATH:$HOME/.environment/commands
export PATH=$PATH:$HOME/.environment/commands/nuvobio

if [[ "$OSTYPE" == "darwin"* ]]; then
  export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
fi

# Pythonpath
export PYTHONPATH=$PYTHONPATH:$HOME/.environment/python

# Aliases
alias vim="nvim"
alias ls='eza'
alias rsync='rsync --progress -v' # always use verbose mode
alias activate='source .venv/bin/activate' # always use verbose mode

# Fetch git repos with CLI when using Cargo
export CARGO_NET_GIT_FETCH_WITH_CLI=true

eval "$(starship init zsh)"
eval "$(~/.nix-profile/bin/mise activate zsh)"
