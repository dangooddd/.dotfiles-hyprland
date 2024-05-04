source /usr/share/fzf/shell/key-bindings.bash
# source /usr/share/fzf/completion.zsh

export FZF_DEFAULT_COMMAND="fd --type file -H --no-ignore . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -H -t d . $HOME"
