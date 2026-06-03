# Global
export EDITOR=nvim
export TERM=xterm-256color

# Environment variables
for f in $HOME/.tokens/*; do source "$f"; done

# Path
if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.environment/commands
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.environment/commands
export PATH=$PATH:$HOME/.environment/commands/nuvobio
export PATH=$PATH:$HOME/.pyenv/shims

# Pythonpath
export PYTHONPATH=$PYTHONPATH:$HOME/.environment/python

# volta
PATH=.volta/bin:$PATH

# Aliases
alias vim="nvim"
alias ls='eza'
alias rsync='rsync --progress -v' # always use verbose mode
alias activate='source .venv/bin/activate' # always use verbose mode

# Fetch git repos with CLI when using Cargo
export CARGO_NET_GIT_FETCH_WITH_CLI=true

eval "$(starship init zsh)"
