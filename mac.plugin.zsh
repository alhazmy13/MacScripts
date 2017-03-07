# ------------------------------------------------------------------------------
# Description
# -----------
#
# A list of shell commands and tools specific to OS X
#
# ------------------------------------------------------------------------------
# Authors
# -------
#
# * Abdullah Alhazmy <me@alhazmy13.net>
#
# ------------------------------------------------------------------------------


## Auto Complete 
fpath=(~/.oh-my-zsh/plugins/mac $fpath) 
autoload -U compinit
compinit
zstyle ':completion:*' menu select=2


function mac() {
case "$1" in
	"files")
		if [ "$2" '==' "hide" ]; then
			defaults write com.apple.finder AppleShowAllFiles NO
			sleep 2
			killall Finder
		elif [ "$2" '==' "show" ]; then
			defaults write com.apple.finder AppleShowAllFiles YES
			sleep 2
			killall Finder
		else
			echo "command missing"
		fi
		;;
	"disk")
	    diskutil list
	    ;;
	"store-app")
		find /Applications -path '*Contents/_MASReceipt/receipt' -maxdepth 4 -print |\sed 's#.app/Contents/_MASReceipt/receipt#.app#g; s#/Applications/##'
		;;
	"icon")
		if [ "$2" '==' "enable" ]; then
			defaults write com.apple.dock no-bouncing -bool true && \
			killall Dock
		elif [ "$2" '==' "disable" ]; then
			defaults write com.apple.dock no-bouncing -bool false && \
			killall Dock
		else
			echo "command missing"
		fi
		;;
	"html")
		textutil -convert html "$2"
		;;
	"bluetooth")
		if [ "$2" '==' "enable" ]; then
			sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 1
		elif [ "$2" '==' "disable" ]; then
			sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 0 && \
			sudo killall -HUP blued
		elif [ "$2" '==' "status" ]; then
			defaults read /Library/Preferences/com.apple.Bluetooth ControllerPowerState
		else
			echo "command missing"
		fi
		;;
	"mamp")
		if [ "$2" '==' "start" ]; then
			/Applications/MAMP/bin/startMysql.sh
			/Applications/MAMP/bin/startApache.sh
		elif [ "$2" '==' "stop" ]; then
			/Applications/MAMP/bin/stopMysql.sh
			/Applications/MAMP/bin/stopApache.sh
		elif [ "$2" '==' "restart" ]; then
			/Applications/MAMP/bin/stopMysql.sh
			/Applications/MAMP/bin/stopApache.sh
			sleep 4
			/Applications/MAMP/bin/startMysql.sh
			/Applications/MAMP/bin/startApache.sh
		else
			echo "command missing"
		fi
		;;
	"android-keystore")
		keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
		;;
	"help")
		echo "Hi"
		;;
esac
}


