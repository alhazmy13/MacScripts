#!/bin/bash
defaults write com.apple.finder AppleShowAllFiles NO
  sleep 2
  killall Finder
  echo "I'm Done, Have a nice day :D" 