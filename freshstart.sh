#!/bin/bash

echo "It seems that you have been caught by Truck-kun. You have to choose the new world you want to live in. Choose wisely!"
	select os in "Linux" "Android" "Termux" "Windows" "MacOS" "Give me a moment"; do
		case $os in
			"Linux")
				./setup/linux-setup.sh
				;;
			"Termux")
				./setup/termux-setup.sh
				;;
			"Windows")
				./setup/windows-setup.sh
				;;
			"MacOS")
				echo "MacOS is not supported yet"
				;;
			"Give me a moment")
				echo "Time wait for no man, even if he is just a spirit."
				;;
		esac
		break
	done





##1. change repo
echo Did you set the repo
##2. Foreword update && upgrade -y
echo Updating packages
##3. 1st Chapter: A fresh Start!
## pkg install neovim git gh


