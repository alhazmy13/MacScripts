#!/bin/bash
RED=`tput setaf 1`
GREEN=`tput setaf 2`
NC=`tput sgr0`

function help {
    echo "usage: $programname [-abc]"
    echo "  -files ${RED}[-show]|[-hide]${NC}	to hide/show all files on your mac"
    echo "  -help				to show a list of commands"
    echo "  -store-app			List All Apps Downloaded from App Store "
    echo "  -disk 			show All Attached Disks and Partitions"
    echo "  -icon ${RED}[-enable]|[-disable]${NC}	enable/disable dock icon bounce "
    echo "  -html ${RED}[file.ext]${NC}		convert file to html, Supported formats (txt,rtf,doc,docx)."
    exit 1
}


case "$1" in
	"-files")
		if ["$2" == "-hide"]; then
			defaults write com.apple.finder AppleShowAllFiles NO
			sleep 2
			killall Finder
		elif ["$2" == "-show"]; then
			defaults write com.apple.finder AppleShowAllFiles YES
			sleep 2
			killall Finder
		else
			echo "command missing"
		fi
		;;
	"-disk")
	    diskutil list
	    ;;
	"-store-app")
		find /Applications -path '*Contents/_MASReceipt/receipt' -maxdepth 4 -print |\sed 's#.app/Contents/_MASReceipt/receipt#.app#g; s#/Applications/##'
		;;
	"-icon")
		if ["$2" == "-enable"]; then
			defaults write com.apple.dock no-bouncing -bool true && \
			killall Dock
		elif ["$2" == "-disable"]; then
			defaults write com.apple.dock no-bouncing -bool false && \
			killall Dock
		else
			echo "command missing"
		fi
		;;
	"-html")
		textutil -convert html "$2"
		;;
	"-help")
		help
		;;
esac

