#!/bin/bash

# Aardwolf-TTmux wrapper script
# This script sets up a local environment for the user in ~/.aardwolf-ttmux

BASE_DIR="/usr/share/aardwolf-ttmux"
USER_DIR="$HOME/.aardwolf-ttmux"
SESSION="aardwolf-tmux"

# Create user directory if it doesn't exist
mkdir -p "$USER_DIR/conf"
mkdir -p "$USER_DIR/log"
mkdir -p "$USER_DIR/map"

# Symlink modules and setup.tin if they don't exist
[ -e "$USER_DIR/modules" ] || ln -s "$BASE_DIR/modules" "$USER_DIR/modules"
[ -e "$USER_DIR/setup.tin" ] || ln -s "$BASE_DIR/setup.tin" "$USER_DIR/setup.tin"

# Copy variables.tin if it doesn't exist (user might want to edit it)
if [ ! -f "$USER_DIR/conf/variables.tin" ]; then
    cp "$BASE_DIR/conf/variables.tin" "$USER_DIR/conf/variables.tin"
fi

# Make sure map and log files exist so tail doesn't crash
touch "$USER_DIR/map/minimap" "$USER_DIR/log/chars" "$USER_DIR/log/affects" "$USER_DIR/log/Aardwolf-chats" "$USER_DIR/log/quest"

cd "$USER_DIR" || exit

# Check if session exists
tmux has-session -t $SESSION 2>/dev/null
if [ $? == 0 ]; then
  tmux kill-session -t $SESSION
fi

# Create tmux session and set up panes
tmux new-session  -d -s $SESSION -c "$USER_DIR" 'tt++ -G setup.tin'
tmux split-window -h -p 40 -c "$USER_DIR"       'tail -F log/quest'
tmux split-window -t 1 -v -p 85 -c "$USER_DIR"  'tail -F map/minimap'
tmux split-window -t 2 -v -p 75 -c "$USER_DIR"  'tail -F log/chars'
tmux split-window -t 3 -v -p 66 -c "$USER_DIR"  'tail -F log/affects'
tmux split-window -t 4 -v -p 50 -c "$USER_DIR"  'tail -F log/Aardwolf-chats'
tmux select-pane -t 0

# Attach session
tmux attach-session -t $SESSION
