# zsh theme requires 256 color enabled terminal
# i.e TERM=xterm-256color
# Preview - http://www.flickr.com/photos/adelcampo/4556482563/sizes/o/
# based on robbyrussell's shell but louder!

ZSH_THEME_GIT_PROMPT_PREFIX="%F{154}±|%f%F{124}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}%B✘%b%F{154}|%f%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%F{154}|"

function my_git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  topdir=$(git rev-parse --show-toplevel)
  reponame=${topdir##*/}
  ((GIT_PROMPT_WIDTH = $#ref + $#reponame + 5))
  export GIT_PROMPT_WIDTH
  echo "$(git_stash_prompt)$ZSH_THEME_GIT_PROMPT_PREFIX${reponame}:${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function my_dir_color() {
  if [[ -O "." ]] then
    if [[ -w "." ]] then
      echo "white"
    else
      echo "yellow"
    fi
  else
    if [[ -w "." ]] then
      echo "green"
    else
      echo "red"
    fi
  fi
}

function spec_dir() {
  ${%~//~ws\//# }
}

function git_stash_prompt  {
  local stash=`expr $(git stash list 2>/dev/null| wc -l)`
  if [ "$stash" != "0" ]                  
  then
    echo "$fg_bold[red]♻$reset_color"
  fi
}

function my_rvm_prompt {                                                                  scottp@smp
  local rvm_type
  local spaces
  local my_path
  my_path=$(print -P %~)

  rvm_type=${${${GEM_HOME##*/}/ruby-/}//-p<0-10000>/}
  ((spaces = ${COLUMNS} - 1 - $#my_path - $#GIT_PROMPT_LENGTH - $#rvm_type))
  echo "git: $#GIT_PROMPT_LENGTH"
  echo "path: $#my_path"
  echo "rvm: $#rvm_type"
  echo "spaces: $spaces"
}

PROMPT='$(my_git_prompt_info) %F{$(my_dir_color)}%~%f 
%{$fg_bold[white]%}%# %{$reset_color%}'
RPROMPT='%B%F{208}%n%f%{$fg_bold[white]%}@%F{039}%m%f%{$reset_color%}'

