#!/bin/bash

target=$1
name=$2

if (($#==2));
then

  ## Create dir structure
  mkdir -p ~/boxes/$name
  mkdir -p ~/boxes/$name/recon
  mkdir -p ~/boxes/$name/loot
  mkdir -p ~/boxes/$name/exploits

  ## Environment setup
  cd ~/boxes/$name
  export target
  export box
  export name

  ## Create Tmux session and windows
  tmux new -d -s 1
  tmux rename-window VPN
  tmux new-window -d -n T1
  tmux new-window -d -n T2
  tmux new-window -d -n T3
  tmux new-window -d -n T4

  ## Startup Commands
  tmux send-keys -t 1:VPN 'vpn' ENTER 
  tmux send-keys -t 1:T1 'nmap -sC -sV $target -p- -oN recon/nmap_tcp_full.txt' 

  ## Attach session
  tmux a -t 1

else
  echo "Usage: ./workspace.sh <IP> <Name_of_Machine>"
  echo "Example: ./workspace.sh 10.11.1.180 180_SERVMON"

fi
