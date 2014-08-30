# Set the default editor
if [ -f /usr/local/bin/subl ]; then
    export EDITOR='subl -w'
elif [ -f /usr/local/bin/mate ]; then
    export EDITOR='mate'
    export GIT_EDITOR='mate -wl1'
else
    export EDITOR="vim"
fi

# no ._ files in archives please
export COPYFILE_DISABLE=true

export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH

#Set TZ using already configured system setting
export TZ='Europe/Brussels'

# fix multibyte errors in ruby 1.9.x
#export RUBYOPT='-Ku'

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# Highlight section titles in manual pages
export LESS_TERMCAP_md="$ORANGE"

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto"

# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
