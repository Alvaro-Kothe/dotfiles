add_file() {
    [ -f $1 ] && . $1
}

path_add () {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1${PATH:+":$PATH"}"
    fi
}

projtmux () {
  local proj_dir=$(find ~/git ~/projects ~/projects/oss ~/ \
    -mindepth 1 -maxdepth 1 -type d \
    -exec test -d '{}/.git' \; -print | fzf)

  # Quit if directory doesn't exist
  [[ -d "$proj_dir" ]] || return

  local proj_name=$(basename "$proj_dir")

  if ! tmux has-session -t "$proj_name" 2>/dev/null; then
    # Create a new session if it doesn't exist
    tmux new-session -d -s "$proj_name" -c "$proj_dir"
  fi

  # Attach or switch to the session based on whether we're already in tmux
  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$proj_name"
  else
    tmux attach-session -t "$proj_name"
  fi
}
