if [[ $(command -v starship) ]]; then
    eval "$(starship init bash)"
fi

if [[ $(command -v fzf) ]]; then
    eval "$(fzf --bash)"
fi
