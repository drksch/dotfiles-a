#!/bin/bash

#Start
echo -e "\033[1mInsperata accidunt magis saepe quam quae speres"
sleep 1

echo -e "Hmm"
sleep 1

echo -e "Well Met traveller. It seems that the Universal Truths of Murphy and the curiosity of his mistress has brought you here once again."
sleep 3

echo -e "**sigh**"
sleep 2

echo -e "Shall we begin your journey again?\033[0m"

select os in \
	"Arch-Heavy" \
	"Arch-Light" \
	"Termux-Android" \
	"Windows" \
	"MacOS" \
	"Give me a moment..." ; do
	case @os in
		"Linux-Light")
			bash ./setup/linuxh_setup.sh
			;;
		"Linux-Arch")
			bash ./setup/linuxl_setup.sh
			;;
		"Termux-Android")
			bash ./setup/termux-setup.sh
			;;
		"Windows")
			bash ./setup/windows-setup.sh
			;;
		"MacOS")
			bash ./setup/doyouhavemacmoney.sh
			;;
		"Give me a moment...")
			echo -e "Time wait for no man, even if he is just a spirit."
			sleep 10
			echo -e "You have been here for too long. It is time to leave."
			exit 0
			;;
	esac
	break
done




