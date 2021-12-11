if [ ! -f ~/.git-prompt.sh ]; then
  curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
fi

if [ ! -f ~/.vim/colors/monokai.vim ] && hash curl 2>/dev/null; then
    mkdir -p ~/.vim/colors
    curl -o ~/.vim/colors/monokai.vim https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim
fi

source ~/.git-prompt.sh
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# enable pretty colors
export TERM='xterm-256color'

# default exports
export PAGER='less'
export EDITOR='vim'
export VISUAL='vim'

# pretty colors and visual appearance on ls
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

  alias ls='ls -lhF --color=auto'
  alias la='ls -lhAF --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
else
  alias ls='ls -lhF'
  alias la='ls -lhAF'
fi

# cp is so 2000 and late
if [ "$OSTYPE" != "msys" ]; then
    alias cp='rsync -avz --progress'
fi

# pretty colors on git log
alias gitlog='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset %Cred(Author: %ae)%Creset" --abbrev-commit --date=relative'

# limit ping requests
alias ping='ping -c 3'

# shortcut to remove all in current dir
alias delall='rm -rf *'

# shortcut for dos2unix all files in current dir
alias dos2unixbomb='find . -type f -print0 | xargs -0 dos2unix'

# shortcut to search aptitude
alias apt-search='apt-cache search'

cdmkdir() {
  mkdir -p $1
  cd $1
}

# step back N times from current directory
stepback() {
  LIMIT=$1
  P=$PWD
  for ((i=1; i <= LIMIT; i++)); do
    P=$P/..
  done
  cd $P
}

# Custom bash prompt
__show_git_info() {
  local g="$(git rev-parse --git-dir 2>/dev/null)"
  git_branch=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  if [ -n "`git status 2> /dev/null | grep "# Untracked files:"`" ]; then
    untracked="*"
  fi
  if [ -n "$g" ]; then
    printf " $(__git_ps1 "(%s)"$untracked)"
  else
    printf ""
  fi
}

function git_branch {
  git_branch=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  if [ -n  "`git status 2> /dev/null | grep "# Untracked files:"`" ]; then
    untracked="*"
  fi
  if [ "`expr "$git_branch" : '.*'`" -gt "0" ]; then
    echo \($git_branch$untracked\)
  fi
}

#PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \
#\[$(tput setaf 5)\]\W\[$(tput setaf 1)\]\$(__show_git_info)]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

# export PS1="\[\e[32m\][\[\e[m\]\u\[\e[32m\]@\[\e[m\]\h\[\e[32m\]]\[\e[m\]\[\e[32m\]\`__show_git_info\`\[\e[m\] \\$ "
# export PS1="\[\e[32m\][\[\e[m\]\u\[\e[32m\]@\[\e[m\]\h\[\e[32m\]]\[\e[m\] \w \[\e[32m\]\`__show_git_info\`\[\e[m\] \\$ "
export PS1="\[\e[32m\][\[\e[m\]\u\[\e[32m\]@\[\e[m\]\h\[\e[32m\]]\[\e[m\] \w\[\e[32m\]\`__show_git_info\`\[\e[m\] \\$ "

# do not keep custom paths and what not from system
if [ "$OSTYPE" != "msys" ]; then
    #export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
    export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
    export PATH="/usr/local/opt/python/libexec/bin:$PATH"
fi

function reduce_video_size {
  absopath=$(echo "$(cd "$(dirname "$1")" && pwd)/")
  filename=$(basename "$1")
  extension="${filename##*.}"
  filename="${filename%.*}"
  bakfile=$absopath/$filename.original.$extension
  newfile=$absopath/$filename.$extension
  mv $1 $bakfile
  ffmpeg -i $bakfile -c:v libx264 -crf 23 $newfile
}

function video_to_gif {
  ffmpeg -i $1 -s 640x360 -pix_fmt rgb8 -r 10 -f gif - | gifsicle --optimize=3 --delay=10 > $1.gif
}

#function make {
#   if [ -f "Makefile" ]; then
#       make
#   elif [ -f "build.ninja" ]; then
#       ninja
#   else
#       echo "Failure"
#   fi
#}

# trips get
if hash screenfetch 2>/dev/null; then
  screenfetch -A "openSUSE"
fi

cd ~
