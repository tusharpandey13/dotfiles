# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="/home/tushar/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is laded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

# MANJARO TWEAKS BEGIN

## Options section
setopt correct						   # Auto correct mistakes
#setopt extendedglob			   # Extended globbing. Allows using regular expressions with *
setopt nocaseglob					   # Case insensitive globbing
setopt rcexpandparam			   # Array expension with parameters
#setopt nocheckjobs				   # Don't warn about running processes when exiting
setopt numericglobsort		   # Sort filenames numerically when it makes sense
setopt nobeep						     # No beep
setopt appendhistory			   # Immediately append history instead of overwriting
#setopt histignorealldups	   # If a new command is a duplicate, remove the older one
#setopt autocd						     # if only directory path is entered, cd there.



zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word


## Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                         # Home key
bindkey '^[[H' beginning-of-line                          # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line          # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                               # End key
bindkey '^[[F' end-of-line                                # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                 # [End] - Go to end of line
fi
#bindkey '^[[2~' overwrite-mode                            # Insert key
bindkey '^[[3~' delete-char                               # Delete key
bindkey '^[[C'  forward-char                              # Right key
bindkey '^[[D'  backward-char                             # Left key
#bindkey '^[[5~' history-beginning-search-backward         # Page up key
#bindkey '^[[6~' history-beginning-search-forward          # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                              #
bindkey '^[Od' backward-word                              #
bindkey '^[[1;5D' backward-word                           #
bindkey '^[[1;5C' forward-word                            #
bindkey '^H' backward-kill-word                           # delete previous word with ctrl+backspace
#bindkey '^[[Z' undo                                       # Shift+tab undo last action

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r


# MANJARO TWEAKS END



zsh_custom_time(){
  echo $(date +"%H:%M")
}

zsh_custom_battery(){
  { cat /sys/class/power_supply/BAT0/capacity;
    cat /sys/class/power_supply/BAT0/status | cut -c1-1; 
  } | sed ':a;N;s/\n/ /;ba'
}

zsh_custom_spacer_1(){
  echo " "
}

POWERLEVEL9K_CUSTOM_TIME="zsh_custom_time"
POWERLEVEL9K_CUSTOM_TIME_BACKGROUND="grey27"
POWERLEVEL9K_CUSTOM_TIME_FOREGROUND="grey50"

POWERLEVEL9K_CUSTOM_BATTERY="zsh_custom_battery"
POWERLEVEL9K_CUSTOM_BATTERY_BACKGROUND="grey23"
POWERLEVEL9K_CUSTOM_BATTERY_FOREGROUND="grey46"

POWERLEVEL9K_CUSTOM_SPACER_1="zsh_custom_spacer_1"
POWERLEVEL9K_CUSTOM_SPACER_1_BACKGROUND="grey19"

POWERLEVEL9K_MODE='nerdfont-complete'

POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=true
POWERLEVEL9K_CHANGESET_HASH_LENGTH=6
POWERLEVEL9K_SHOW_CHANGESET=true


POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir_writable dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs custom_battery custom_time)
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# begin p10k stuff

# POWERLEVEL9K_LEGACY_ICON_SPACING=true

ZSH_THEME="powerlevel10k/powerlevel10k"


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="true"

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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting encode64 sudo zsh-autosuggestions)
#removed common-aliases from above
source $ZSH/oh-my-zsh.sh


# User configuration


# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#exp
#use a cache for completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

#Fuzzy matching of completions for when you mistype them:
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric


#And if you want the number of errors allowed by _approximate to increase with the length of what you have typed so far:
#zstyle -e ':completion:*:approximate:*' \
#        max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'


#Ignore completion functions for commands you don’t have:
zstyle ':completion:*:functions' ignored-patterns '_*'


#quick change dir
rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

