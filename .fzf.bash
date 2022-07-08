# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/advena/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/advena/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/advena/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/advena/.fzf/shell/key-bindings.bash"
