export HISTSIZE=50000
if command -v nvim > /dev/null; then
  export MANPAGER='nvim +Man!'
fi
export MANWIDTH=999
export EDITOR="nvim"

path_add "$HOME/bin"
path_add "${GOPATH:-$HOME/go}/bin"
path_add "$HOME/.cargo/bin"
path_add "$HOME/.local/bin"
path_add "$HOME/.pixi/bin"
