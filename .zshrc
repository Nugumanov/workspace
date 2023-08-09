export TERM="xterm-256color"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="nerdfont-complete"

# User with skull
user_with_skull() {
    echo -n " t.nugumanov"
}
python() {
    python --version
}
POWERLEVEL9K_CUSTOM_USER="user_with_skull"

# Prompt elements
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv custom_user dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_VIRTUALENV_BACKGROUND='002'
# POWERLEVEL9K_PROMPT_ON_NEWLINE

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(core
	git
	zsh-autosuggestions
	virtualenv
	virtualenvwrapper
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#alias ll='ls -lah'
alias lt='ls --tree'
alias dpa='docker ps -a'
alias restart-hg='~/projects/tools/restart-hg/restart-hg.sh'

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
PATH=$PATH:/Users/t.nugumanov/.local/bin/
PATH=$PATH:/Users/t.nugumanov/Library/Python/3.8/bin
PATH=$PATH:/usr/local
GOPATH=$(go env GOPATH)/bin
PATH=$PATH:$GOPATH

#alias core-cli = '/Users/t.nugumanov/.local/bin/core'

if [ -x "$(command -v exa)" ]; then
	alias ls="exa"
	alias ll='exa --long --all --group'
fi

alias q=exit
alias k=kubectl
alias ktx=kubectx
alias kns=kubens
alias viml="vim -R -c 'set syntax=yaml' -"
alias k3="k9s --context=linx3 -n r-news-prod"
alias k5="k9s --context=linx5 -n r-news"
alias k6="k9s --context=linx6 -n r-news"
alias ressh="ssh $(tmux display-message -p '#W')"
alias cl="clear"
alias grer="grep -R -n"
alias dpa="docker ps -a"

compdef __start_kubectl k

alias haste='HASTE_SERVER=https://pastebin.rambler-co.ru/ haste | pbcopy && echo "Complete and copy ($(pbpaste))!"'
alias exthaste='HASTE_SERVER=https://hastebin.com haste | pbcopy && echo "Complete and copy external($(pbpaste))!"'
cd ~

countdown() {
	start="$(( $(date '+%s') + $1))"
	while [ $start -ge $(date +%s) ]; do
		time="$(( $start - $(date +%s) ))"
		printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
		sleep 0.1
	done
}

stopwatch() {
	start=$(date +%s)
	while true; do
		time="$(( $(date +%s) - $start))"
		printf '%s\r' "$(date -u -j -f %s "$time" +%H:%M:%S)"
		#echo -ne "$(date -ju -f %s $(($date1 - date +%s)) +%H:%M:%S)\r"
		sleep 0.1
	done
}

export GITLAB_ACCESS_TOKEN=$(cat ~/projects/gitlab/.gitlab_access_token)
export HOMEBREW_NO_AUTO_UPDATE=1
export PATH="/usr/local/opt/libpq/bin:$PATH"
