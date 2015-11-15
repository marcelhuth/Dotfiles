# .bash_profile
#
# Marcel's bash_profile
#
# Sets some stuff to make things work better for me.
#
# Based on:
#  https://github.com/trulleberg/Dotfiles
#  https://github.com/mathiasbynens/dotfiles

# TODO: Check if git is installed before using it.

# Color settings
if [ "$(uname)" == "Darwin" ]; then
	# Do something under Mac OS X platform
	#Add colors
	export CLICOLOR=1
	export LSCOLORS=exfxcxdxbxegedabagacad
	export GREP_OPTIONS='--color=auto'
elif [ $(uname) = "Linux" ]; then
	export LS_OPTIONS=' --color=auto'
	export GREP_OPTIONS='--color=auto'
fi

# ANSI color codes
# Has to be ANSI codes! '\e[...' does not work with
# newline in bash. That would cause Ctrl+A to not work properly
RS="\[\033[0m\]"    # reset
HC="\[\033[1m\]"    # hicolor
UL="\[\033[4m\]"    # underline
INV="\[\033[7m\]"   # inverse background and foreground
FBLK="\[\033[30m\]" # foreground black
FRED="\[\033[31m\]" # foreground red
FGRN="\[\033[32m\]" # foreground green
FYEL="\[\033[33m\]" # foreground yellow
FBLE="\[\033[34m\]" # foreground blue
FMAG="\[\033[35m\]" # foreground magenta
FCYN="\[\033[36m\]" # foreground cyan
FWHT="\[\033[37m\]" # foreground white
BBLK="\[\033[40m\]" # background black
BRED="\[\033[41m\]" # background red
BGRN="\[\033[42m\]" # background green
BYEL="\[\033[43m\]" # background yellow
BBLE="\[\033[44m\]" # background blue
BMAG="\[\033[45m\]" # background magenta
BCYN="\[\033[46m\]" # background cyan
BWHT="\[\033[47m\]" # background white

# Alias definitions
if [ "$(uname)" == "Darwin" ]; then
	# There is no --color=auto parameter on MacOS, use -G instead
	alias ls='ls -G'
	alias ll='ls -FGlahp'
elif [ $(uname) = "Linux" ]; then
	# Fix for Ubuntu seems to not care about LSCOLORS set
	alias ls='ls --color=auto'
	alias ll='ls -Flahp --color=auto'
fi
# Useful other aliases
alias cp='cp -iv'
alias mv='mv -iv'
alias df='df -h'
alias vi='vim'
alias ..='cd ..' # Go up one directory
alias ...='cd ../..' # Go up two directories

# New Functions for the Bash
#   cdf:  'Cd's to frontmost window of MacOS Finder
#   ------------------------------------------------------
# Its only available on MacOS
if [ "$(uname)" == "Darwin" ]; then
cdf () {
  currFolderPath=$( /usr/bin/osascript <<EOT
    tell application "Finder"
      try
    set currFolder to (folder of the front window as alias)
      on error
    set currFolder to (path to desktop folder as alias)
      end try
      POSIX path of currFolder
    end tell
EOT
  )
  echo "cd to \"$currFolderPath\""
  cd "$currFolderPath"
}
fi

# Path definition
# Be save that git and homebrew is in the PATH
export PATH=/usr/local/git/bin:/usr/local/bin:$PATH

# Complete additional commands
# Complete git commands
source ~/.git-completion.bash
# Complete aws commands only of aws command are installed
# For now MacOS only
if [ `which aws` ]; then
	complete -C '/Library/Frameworks/Python.framework/Versions/3.4/bin/aws_completer' aws
fi

#-----------------------------------------------
# Functions for the prompt:
#-----------------------------------------------
# Determine if there is a Python virtualenv and present the details, if there is one.
function python_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
    PYTHON_VIRTUALENV=""
  else
    PYTHON_VIRTUALENV="[`basename $VIRTUAL_ENV`] "
  fi
}

function git_prompt_vars() {
  PROMPT_DIRTY=${FRED}'✗'${RS}
  PROMPT_CLEAN=${FGRN}'✓'${RS}
  PROMPT_PREFIX='|'
  PROMPT_SUFFIX='|'
  GIT_BEHIND_CHAR=${FRED}'↓'
  GIT_AHEAD_CHAR=${FGRN}'↑'
  GIT_STASH=''
  GIT_AHEAD=''
  GIT_BEHIND=''

  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == "true" ]]; then
    local status="$(git status -b --porcelain 2> /dev/null || git status --porcelain 2> /dev/null)"
    if [[ -n "${status}" ]] && [[ "${status}" != "\n" ]] && [[ -n "$(grep -v ^# <<< "${status}")" ]]; then
      GIT_STATE=$PROMPT_PREFIX$PROMPT_DIRTY$PROMPT_SUFFIX
    else
      GIT_STATE=$PROMPT_PREFIX$PROMPT_CLEAN$PROMPT_SUFFIX
    fi
    local ref=$(git symbolic-ref -q HEAD 2> /dev/null)
    if [[ -n "$ref" ]]; then
      BRANCH=${ref#refs/heads/}
    else
      BRANCH=$(git describe --tags --exact-match 2> /dev/null)
    fi

    local ahead_re='.+ahead ([0-9]+).+'
    local behind_re='.+behind ([0-9]+).+'
    [[ "${status}" =~ ${ahead_re} ]] && GIT_AHEAD="${GIT_AHEAD_CHAR}${BASH_REMATCH[1]}"
    [[ "${status}" =~ ${behind_re} ]] && GIT_BEHIND="${GIT_BEHIND_CHAR}${BASH_REMATCH[1]}"
    local stash_count="$(git stash list 2> /dev/null | wc -l | tr -d ' ')"
    [[ "${stash_count}" -gt 0 ]] && GIT_STASH="{${stash_count}}"


    GPS="[$BRANCH$GIT_STATE$GIT_AHEAD$GIT_BEHIND$GIT_STASH${RS}] "
  else
    GPS=""
  fi
}

# Set the prompt
prompt() {
  python_virtualenv
  git_prompt_vars
  case $(id -u) in
    0) PS1="\n${RS}(\!) ${FRED}\u${RS}@\h $GPS${FCYN}\w${RS}\n${FMAG}$PYTHON_VIRTUALENV${RS}\$ "
#   0) PS1="\n${RS}(\!) ${BRed}\u${RS}@\h $GPS${Cyan}\w${RS}\n\$ "
    ;;
    *) PS1="\n${RS}(\!) ${FGRN}\u${RS}@\h $GPS${FCYN}\w${RS}\n${FMAG}$PYTHON_VIRTUALENV${RS}# "
#   *) PS1="\n${RS}(\!) ${Green}\u${RS}@\h $GPS${Cyan}\w${RS}\n\$ "
    ;;
  esac
}

PROMPT_COMMAND=prompt
