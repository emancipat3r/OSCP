#!/bin/bash

target=$1
name=$2

if (($#==1));
then
	if (($1=='-h'));
	then
		echo "sudo ~/repos/OSCP/workspace.sh [IP] [NAME]"
	fi
fi

if (($#==2));
then

  ## Create dir structure
  mkdir -p ~/boxes/htb/$name
  mkdir -p ~/boxes/htb/$name/recon
  mkdir -p ~/boxes/htb/$name/loot
  mkdir -p ~/boxes/htb/$name/exploits

  ## Environment setup
  cd ~/boxes/htb/$name
  export target
  cd ~/boxes/$name
  export IP=$target
  export box
  export name

  ## Create Tmux session and windows
  tmux new -d -s 1
  tmux rename-window VPN
  tmux new-window -d -n T1
  tmux new-window -d -n T2
  tmux new-window -d -n T3
  tmux new-window -d -n T4
  tmux new-window -d -n T5

  ## Startup Commands
  tmux send-keys -t 1:VPN 'vpn' ENTER
  tmux send-keys -t 1:T1 'sudo ~/repos/OSCP/init_scans.sh $IP'


  ## Attach Session
  tmux send-keys -t 1:VPN 'vpn' ENTER
  tmux send-keys -t 1:T1 'cd ~/boxes/$name; sudo ~/repos/OSCP/init_scans.sh $IP'

  ## Attach session
  tmux a -t 1

else

  ## Create Tmux session and windows
  tmux new -d -s 1
  tmux rename-window VPN
  tmux new-window -d -n T1
  tmux new-window -d -n T2
  tmux new-window -d -n T3
  tmux new-window -d -n T4
  tmux new-window -d -n T5

  ## Startup Commands
  tmux send-keys -t 1:VPN 'vpn' ENTER

  ## Attach session
  tmux a -t 1

fi
