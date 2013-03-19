# Vania's personal bashrc

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi




### git work ###
# Configure colors, if available.
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  c_reset='\[\e[0m\]'
  c_user='\[\e[1;32m\]'
  c_path='\[\e[0;33m\]'
  c_git_cleancleann='\[\e[0;36m\]'
  c_git_dirty='\[\e[0;35m\]'
else
  c_reset=
  c_user=
  c_git_cleancleann_path=
  c_git_clean=
  c_git_dirty=
fi

# Function to assemble the Git parsingart of our prompt.
git_prompt ()
{
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi

  git_branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')

  if git diff --quiet 2>/dev/null >&2; then
    git_color="$c_git_clean"
  else
    git_color="$c_git_dirty"
  fi

  echo "[$git_color$git_branch${c_reset}]"
}

# Thy holy prompt.
PROMPT_COMMAND='PS1="${c_user}\u${c_reset}@${c_user}\h${c_reset}:${c_path}\w${c_reset}$(git_prompt)\$ "'

cloneall ()
{
for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master `; do
   git branch --track ${branch#remotes/origin/} $branch
done
}
### end git work ###

### school work ###
# alias for cs61a-ko login
alias lcs='ssh -X cs61a-ko@star.cs.berkeley.edu' ## change XX to your login
## copy hw
STAR='cs61a-ko@star.cs.berkeley.edu:~' ## change XX to your login
function copyhw {
FOLDER=`echo "$1" | cut -d'.' -f1`
scp $1 $STAR/class/hw/$FOLDER/
}
