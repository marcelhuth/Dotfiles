# .bash_profile
# Sets some stuff to make things work better for me.

# Define color variables
# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[0;105m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White

# Alias definitions
alias ls='ls -G'
alias cp='cp -iv'
alias mv='mv -iv'
alias ll='ls -FGlAhp'

# New Functions for the Bash
#   cdf:  'Cd's to frontmost window of MacOS Finder
#   ------------------------------------------------------
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

# Path definition
export PATH=/Library/Frameworks/Python.framework/Versions/3.4/bin:/usr/local/git/bin:$PATH

# Complete additional commands
complete -C '/Library/Frameworks/Python.framework/Versions/3.4/bin/aws_completer' aws

# Determine if there is a Python virtualenv and present the details, if there is one.
function python_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
    PYTHON_VIRTUALENV=""
  else
    PYTHON_VIRTUALENV="[`basename $VIRTUAL_ENV`]"
  fi
}

function git_prompt_vars() {
  PROMPT_DIRTY=${BRed}'✗'${Color_Off}
  PROMPT_CLEAN=${BGreen}'✓'${Color_Off}
  PROMPT_PREFIX='|'
  PROMPT_SUFFIX='|'
  GIT_BEHIND_CHAR=${Red}'↓'
  GIT_AHEAD_CHAR=${Green}'↑'
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


    GPS="["$BRANCH$GIT_STATE$GIT_AHEAD$GIT_BEHIND$GIT_STASH${Color_Off}"] "
  else
    GPS=""
  fi
}

# Set the prompt
prompt() {
  python_virtualenv
  git_prompt_vars
  case $(id -u) in
    0) PS1="\n${Color_Off}(\!) ${BRed}\u${Color_Off}@\h $GPS${Cyan}\w${Color_Off}\n${Purple}$PYTHON_VIRTUALENV${Color_Off}\$ "
#    0) PS1="\n${Color_Off}(\!) ${BRed}\u${Color_Off}@\h $GPS${Cyan}\w${Color_Off}\n\$ "
    ;;
    *) PS1="\n${Color_Off}(\!) ${Green}\u${Color_Off}@\h $GPS${Cyan}\w${Color_Off}\n${Purple}$PYTHON_VIRTUALENV${Color_Off}\$ "
#    *) PS1="\n${Color_Off}(\!) ${Green}\u${Color_Off}@\h $GPS${Cyan}\w${Color_Off}\n\$ "
    ;;
  esac
}

PROMPT_COMMAND=prompt
