#!/usr/bin/env bash

if [ -h /usr/bin/nfl-stats ]; then 
    sudo rm /usr/bin/nfl-stats
fi

if [ -e $(pwd)/nfl_stats ]; then
    sudo ln -s $(pwd)/nfl_stats /usr/bin/nfl-stats
else
    echo "Binary not found"
    exit 1
fi
