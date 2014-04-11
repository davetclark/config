#!/bin/bash

CONFIGDIR=$HOME/config
OLDDIR=$HOME/config_old
FILES=".tmux.conf"

# Make sure old dir is present
echo "Ensuring existance of directory $OLDDIR"
mkdir -p $OLDDIR
echo "...done"

pushd $CONFIGDIR

for file in $FILES; do
    homefile=$HOME/$file
    if [ -e $homefile ] && [ ! -h $homefile ]; then
        echo "Backing up $file"
        mv $homefile $OLDDIR
    fi

    echo "Ensuring symlink to versioned file"
    if [ ! -h $homefile ]; then
        ln -s $CONFIGDIR/$file $homefile
    fi
done

popd
