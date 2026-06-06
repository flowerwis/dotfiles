# =============================================================
# PATH
# =============================================================
export PATH="$HOME/.local/bin:$PATH"
export DISCORDO_TOKEN="MTAxNTYxMTIxMzIxMzg1OTg2MA.GIzNF3.7yJLk0is8nlWZ_fU4jf2DoXIqEvbPJYrKJe6Ak" discordo

# =============================================================
# HISTORY
# =============================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS      # don't save duplicate consecutive entries
setopt HIST_IGNORE_SPACE     # don't save lines starting with a space
setopt HIST_VERIFY           # show expanded history before running
setopt SHARE_HISTORY         # share history across all open terminals
setopt APPEND_HISTORY        # append rather than overwrite

# =============================================================
# VI MODE
# =============================================================
bindkey -v
KEYTIMEOUT=1

# Block cursor = normal mode, beam cursor = insert mode
function zle-keymap-select() {
    case $KEYMAP in
        vicmd)      echo -ne '\e[1 q' ;;  # block
        viins|main) echo -ne '\e[5 q' ;;  # beam
    esac
}
zle -N zle-keymap-select

# Reset to beam on each new prompt
function zle-line-init() {
    zle -K viins
    echo -ne '\e[5 q'
}
zle -N zle-line-init

# Beam cursor when shell starts
echo -ne '\e[5 q'

# Keybinds: up/down arrows for history search (insert mode)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Keybinds: j/k for history search (vi normal mode)
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Accept autosuggestion with right arrow
bindkey '^[[C' autosuggest-accept
bindkey '^[OC' autosuggest-accept
# =============================================================
# PLUGINS
# =============================================================

# 1. Autosuggestions (fish-style gray ghost text)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# 2. Syntax highlighting (fish-style command coloring) — must come AFTER autosuggestions
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# 3. History substring search (up/down filters by what you've typed)
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh


# =============================================================
# ALIASES  (from config.fish — interactive block)
# =============================================================
alias v='nvim'
alias cfs='nvim ~/.config/sway/config'
alias cfl='nvim ~/.config/swaylock/config'
alias cfw='nvim ~/.config/waybar'
alias cff='nvim ~/.zshrc'                   
alias s='spotify_player'
alias p='sudo pacman'
alias y='yay'
alias sw='~/.local/bin/swallow.sh'
alias ls='ls -lah --color=auto'
alias weather="curl 'https://wttr.in/'"
alias dot='git --git-dir=/home/cirno/.dotfiles/ --work-tree=/home/cirno'

setopt PROMPT_SUBST

# Replicate fish's prompt_pwd: shorten intermediate dirs to first letter
_fish_style_pwd() {
    local raw
    if [[ "$PWD" == "$HOME" ]]; then
        echo "~"
        return
    elif [[ "$PWD" == "$HOME/"* ]]; then
        raw="~/${PWD#$HOME/}"
    else
        raw="$PWD"
    fi
    # Split on /, shorten every segment except the last one
    echo "$raw" | awk -F/ '{
        for (i=1; i<NF; i++) {
            if ($i == "~" || $i == "") printf "%s/", $i
            else printf "%s/", substr($i,1,1)
        }
        print $NF
    }'
}

PROMPT='%B%F{9}[%f%b%F{11}%n%f%F{10}@%f%F{12}%m%f %F{13}$(_fish_style_pwd)%f%F{9}]%f%F{15}$ %f'

