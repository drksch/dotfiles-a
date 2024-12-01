#!/bin/bash

# Start
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
  case $os in
    "Arch-Heavy")
      echo "Running script: ./setup/linuxh_setup.sh"
      if [ -f "./setup/linuxh_setup.sh" ]; then
        echo "Script found, running..."
        bash ./setup/linuxh_setup.sh
      else
        echo "Error: Script not found!"
      fi
      ;;
    "Arch-Light")
      echo "Running script: ./setup/linuxl_setup.sh"
      if [ -f "./setup/linuxl_setup.sh" ]; then
        echo "Script found, running..."
        bash ./setup/linuxl_setup.sh
      else
        echo "Error: Script not found!"
      fi
      ;;
    "Termux-Android")
      echo "Running script: ./setup/termux-setup.sh"
      if [ -f "./setup/termux-setup.sh" ]; then
        echo "Script found, running..."
        bash ./setup/termux-setup.sh
      else
        echo "Error: Script not found!"
      fi
      ;;
    "Windows")
      echo "Running script: ./setup/windows-setup.sh"
      if [ -f "./setup/windows-setup.sh" ]; then
        echo "Script found, running..."
        bash ./setup/windows-setup.sh
      else
        echo "Error: Script not found!"
      fi
      ;;
    "MacOS")
      echo "Running script: ./setup/doyouhavemacmoney.sh"
      if [ -f "./setup/doyouhavemacmoney.sh" ]; then
        echo "Script found, running..."
        bash ./setup/doyouhavemacmoney.sh
      else
        echo "Error: Script not found!"
      fi
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
