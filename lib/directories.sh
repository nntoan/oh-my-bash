#!/usr/bin/env bash
# Common directories functions

# A clone of Zsh `cd` builtin command
function cd() {
  declare oldpwd="$OLDPWD"
  declare -i index
  if [[ "$#" -eq 1 && "$1" == -[1-9]* ]]; then
    index="${1#-}"
    if [[ "$index" -ge "${#DIRSTACK[@]}" ]]; then
      builtin echo "cd: no such entry in dir stack" >&2
      return 1
    fi
    set -- "${DIRSTACK[$index]}"
  fi
  builtin pushd . >/dev/null &&
    OLDPWD="$oldpwd" builtin cd "$@" &&
    oldpwd="$OLDPWD" &&
    builtin pushd . >/dev/null &&
    for ((index="${#DIRSTACK[@]}"-1; index>=1; index--)); do
      if [[ "${DIRSTACK[0]/#~/$HOME}" == "${DIRSTACK[$index]}" ]]; then
        builtin popd "+$index" >/dev/null || return 1
      fi
    done
  OLDPWD="$oldpwd"
}

alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels

alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias md='mkdir -p'
alias rd='rmdir'
alias d='dirs -v | head -10'
alias po=popd

# List directory contents
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
