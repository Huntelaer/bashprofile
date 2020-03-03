function parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function git_branch_alert_master() {
  branch=$(parse_git_branch 2> /dev/null)
  if [ "$branch" = "(master)" ]; then
     echo -e "\033[1;31m${branch}\033[1;39;49m" # white on red
  elif [ "$branch" = "" ]; then
     echo -e ""
  else
     echo -e "${branch}"
  fi
}

function git_has_changes() {
  changes=$(git status --porcelain 2> /dev/null)
  #if [[ `git status --porcelain 2> /dev/null` ]]; then
  if [[ $changes ]]; then
    # Changes
    echo -e "*"
  else
    echo -e ""
    # No changes
  fi
}


RED="\[\033[1;31m\]"
YELLOW="\[\033[1;33m\]"
GREEN="\[\033[1;32m\]"
NO_COLOUR="\[\033[0m\]"
LIGHT_CYAN="\[\033[1;36m\]"
BLUE="\[\033[1;34m\]"
PURPLE="\[\033[1;35m\]"
PS1="\n$GREEN\u$GREEN:\w$LIGHT_CYAN \$(git_branch_alert_master)\$(git_has_changes)\n$NO_COLOUR$ "
