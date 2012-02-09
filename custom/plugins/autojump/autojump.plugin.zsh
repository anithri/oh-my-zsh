aj=/usr/share/autojump/autojump.zsh
aj2=/etc/profile.d/autojump.zsh
if [ -f $aj ]; then
  . $aj
elif [ -f $aj2 ]; then
  . $aj2
fi
