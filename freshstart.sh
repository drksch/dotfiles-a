#!/bin/bash

echo "It seems that you have been caught by Truck-kun. You have to choose the new world you want to live in. Choose wisely!"
	select os in "Linux" "Termux" "Windows" "MacOS" "Give me a moment"; do
		case $os in
			"Linux")
				bash ./setup/linux-setup.sh
				;;
			"Termux")
				bash ./setup/termux-setup.sh
				;;
			"Windows")
				bash ./setup/windows-setup.sh
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








