if [[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]]; then
  source /usr/share/git-core/contrib/completion/git-prompt.sh
  export GIT_PS1_SHOWDIRTYSTATE=1
  export PROMPT_DIRTRIM=3
  export PS1='\[\e[1;36m\]\w\[\e[0;33m\]$(__git_ps1 " (%s)")\[\e[1;32m\] \$\[\e[0m\] '
fi

if [[ $(command -v fzf) ]]; then
    eval "$(fzf --bash)"
fi
