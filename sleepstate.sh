#!/bin/bash

# <bitbar.title>sleepstate.sh</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Radi</bitbar.author>
# <bitbar.author.github>Alyoscha</bitbar.author.github>
# <bitbar.desc>Show and set sleepstate</bitbar.desc>
# <bitbar.image></bitbar.image>


# Documentation: https://github.com/matryer/bitbar

export PATH='/usr/bin:$PATH'

# Check for actions
if [ "$1" == "awake" ] ; then
  sudo pmset -a disablesleep 1
  sudo pmset -b sleep 0
  sudo pmset -c sleep 0
elif [ "$1" == "sleep" ] ; then
  sudo pmset -a disablesleep 0
  sudo pmset -b sleep 15
  sudo pmset -c sleep 0
fi

# Determine actual state
pmset -g | grep -qE "SleepDisabled.*1"
if [ $? -eq 0 ] ; then
  AWAKE=1
else
  AWAKE=0
fi

# Put state into menu bar
case $AWAKE in
  0) echo "sleep" ;;
  1) echo "awake" ;;
  *) echo "unknown" ;;
esac

# Rest of any output goes into menu
echo "---"

# Create menu and define action - script calls itself for an action
echo "keep awake | terminal=false refresh=true bash='$0' param1=awake"
echo "allow sleep | terminal=false refresh=true bash='$0' param1=sleep"

