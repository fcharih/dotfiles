# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/flexplicateur/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/flexplicateur/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/flexplicateur/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/flexplicateur/.fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'

