#!/bin/bash

#tmux session name
SESSION="aardwolf-tmux"

#Get script directory
DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/..
cd $DIR || exit

tmux has-session -t $SESSION 2>/dev/null
if [ $? == 0 ]; then
  tmux kill-session -t $SESSION
fi

#Make sure the map and log files exist so tail doesn't crash 
mkdir -p log
mkdir -p map
touch map/minimap log/chars log/affects log/Aardwolf-chats log/quest

#Create tmux session and set up panes
tmux new-session  -d -s $SESSION -c $DIR 'tt++ -G setup.tin'
tmux split-window -h -p 40 -c $DIR       'tail -F log/quest'
tmux split-window -t 1 -v -p 85 -c $DIR  'tail -F map/minimap'
tmux split-window -t 2 -v -p 75 -c $DIR  'tail -F log/chars'
tmux split-window -t 3 -v -p 66 -c $DIR  'tail -F log/affects'
tmux split-window -t 4 -v -p 50 -c $DIR  'tail -F log/Aardwolf-chats'
tmux select-pane -t 0

#Attach session
tmux attach-session -t $SESSION
