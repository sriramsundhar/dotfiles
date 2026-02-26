#only for bell
source ~/.zprofile
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source "$(nix eval nixpkgs#zinit.outPath --raw)/share/zinit/zinit.zsh"
source "$(nix eval nixpkgs#zsh-history-substring-search.outPath --raw)/share/zsh-history-substring-search/zsh-history-substring-search.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::autojump
zinit snippet OMZP::nvm
zinit snippet OMZ::plugins/git/git.plugin.zsh

zinit load zsh-users/zsh-history-substring-search
zinit ice wait atload'_history_substring_search_config'

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

eval "$(direnv hook zsh)"
# Aliases
alias ls='colorls'
alias ll='colorls -al'
alias c='clear'
alias fz='nvim $(fzf -m --preview="bat --color=always {}")'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
export PATH="$PATH:$HOME/bin:$HOME/.tmux/plugins/tmuxifier/bin"
eval "$(tmuxifier init -)"
eval "$(mise activate zsh)"
# Added by Antigravity
export PATH="/Users/admin/.antigravity/antigravity/bin:$PATH"
#litellm dummy
export LITELLM_MASTER_KEY=sk-1234
export LITELLM_SALT_KEY=sk1234
export ANTHROPIC_AUTH_TOKEN=$LITELLM_MASTER_KEY

