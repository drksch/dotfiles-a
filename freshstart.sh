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
	"\033[31mLinux-Deb\033[0m" \
	"\033[34mLinux-Arch\033[0m" \
	"\033[32mTermux-Android\033[0m" \
	"\033[36mWindows\033[0m" \
	"\033[30mMacOS\033[0m" \
	"Give me a moment..." ; do
	case @os in
		"\033[31mLinux-Deb\033[0m")
			bash ./setup/linuxd_setup.sh
			;;
		"\033[34mLinux-Arch\033[0m")
			bash ./setup/linuxa_setup.sh
			;;
		"\033[32mTermux-Android\033[0m")
			bash ./setup/termux-setup.sh
			;;
		"\033[36mWindows\033[0m")
			bash ./setup/windows-setup.sh
			;;
		"\033[30mMacOS\033[0m")
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




