#!/bin/bash

# Menu title
echo "Choose a new world to live in:"

# Define the options with colors
options=(
  "\033[32mLinux\033[0m"
  "\033[34mArch-Mini\033[0m"
  "\033[31mTermux\033[0m"
  "\033[36mWindows\033[0m"
  "\033[33mMacOS\033[0m"
  "\033[35mGive me a moment\033[0m"
  "\033[37mExit\033[0m"
)

# Display the options and get the user's input
while true; do
  for i in "${!options[@]}"; do
    echo "$((i+1)). ${options[i]}"
  done
  read -p "Enter the number of your choice: " choice
  case $choice in
    1) bash ./setup/linux-setup.sh ;;
    2) bash ./setup/archmini-setup.sh ;;
    3) bash ./setup/termux-setup.sh ;;
    4) bash ./setup/windows-setup.sh ;;
    5) echo "MacOS is not supported yet" ;;
    6) echo "Time wait for no man, even if he is just a spirit." ;;
    7) echo "Goodbye!" && exit 0 ;;
    *) echo "Invalid choice. Please try again." ;;
  esac
done
