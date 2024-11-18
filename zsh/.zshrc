# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
export ZSH_PLUGIN_DIR="$ZSH_DATA/plugins"
export ZSH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
fpath+="$ZSH_DATA/completion"

HISTFILE=~/.zsh_history
setopt appendhistory

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP

# completions
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion::complete:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.
setopt nomenucomplete

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$ZSH_CONFIG/zsh-functions"

# Normal files to source
zsh_add_file "$ZSH_CONFIG/zsh-exports"
zsh_add_file "$ZSH_CONFIG/zsh-aliases"
zsh_add_file "$ZSH_CONFIG/zsh-keybinds"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "romkatv/powerlevel10k"


[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.asdf/asdf.sh ] && source ~/.asdf/asdf.sh
# export FZF_DEFAULT_COMMAND='rg --hidden -l ""'

# Edit line in vim with ctrl-e:
# autoload edit-command-line; zle -N edit-command-line
# bindkey '^e' edit-command-line



# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
  [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
else
  [[ ! -f ~/.config/zsh/.p10k-tty.zsh ]] || source ~/.config/zsh/.p10k-tty.zsh
fi
