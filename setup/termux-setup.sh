#!/bin/bash

#Next Update to Make it Colorful
DM='\033[92;100;1m'
NC='\033[0m'

# Check if mirrors have been changed
if [ -f /data/data/com.termux/files/usr/etc/apt/sources.list ]; then
    if grep -q "asia" /data/data/com.termux/files/usr/etc/apt/sources.list; then
        echo -e ${DM} "It seems that you have chosen where to start, young adventurer. [Asian Mirror]"${NC}
        exit
    fi
fi

# Prompt user to choose the Asian Mirror
echo -e ${DM} "Seems you need to start somewhere. May I suggest Anisa?"${NC}
select choice in "Yes" "No"; do
    case $choice in
        "Yes")
            termux-change-repo asia
            echo -e ${DM} "Wise choice."${NC}
            ;;
        "No")
            echo -e ${DM} "Then I leave that to you adventurer. If you need help, use the spell
	    termux-change-repo. "${NC}
            ;;
    esac
    break
done

sleep 2
echo -e ${DM} "Let's upgrade your base system with some added authorization."${NC}
pkg upgrade -y
pkg install -y gh which openssh wget
echo -e ${DM} "Done...Now it is best to give you starting equipment..:"${NC}
sleep 2

# Prompt to install packages
echo -e ${DM} "Shall I give you some basic tools. (neovim, git, cmake, stylua, lua-language-server, nodejs)"${NC}
select install_choice in "Yes" "No"; do
    case $install_choice in
        "Yes")
            echo -e ${DM} "Here you go, Android. Downloading tools for Survival"${NC}
            # Gather all non-installed programs in one command
            packages_to_install=$(for package in neovim git cmake stylua lua-language-server nodejs-lts clang; do
                if ! pkg info -I $package >/dev/null 2>&1; then
                    echo -e ${DM} -n "$package "
                fi
            done)
            if [ -n "$packages_to_install" ]; then
                pkg install -y $packages_to_install
                echo -e ${DM} "I hope these will help you. [Installed: $packages_to_install]"${NC}
            else
                echo -e ${DM} "Ahh seems you have all the tools."${NC}
            fi
            ;;
        "No")
            echo -e ${DM} "Hmm..Another time then."${NC}
            ;;
    esac
    break
done

    echo -e ${DM} "Now you have your grimoire, lets kickstart your journey. I have something here to get you started. Would you like to see?"${NC}
    select kickstart_choice in "Yes" "No"; do
        case $kickstart_choice in
            "Yes")
                echo -e ${DM} "Conjouring spell Rekindle..."${NC}
                if git clone -b android --single-branch https://github.com/drksch/kickstart.nvim.git ~/.config/nvim/; then
                    echo -e ${DM} "Rekindle Magic Circle Casted. [Kickstart:Ok]"${NC}
                else
                    echo -e ${DM} "Strange...Something went wrong."${NC}
                fi
                ;;
            "No")
                echo -e ${DM} "Rekinde not installed."${NC}
                ;;
        esac
        break
    done
sleep 2

# Custom Terminal
# Prompt to install dotfiles and other tools
echo -e ${DM} "Would you like to install a custom terminal?"${NC}
select dotfiles_choice in "Yes" "No"; do
    case $dotfiles_choice in
        "Yes")
            echo -e ${DM} "Installing dotfiles and other tools..."${NC}
            # Clone dotfiles repository and copy to ~/.config
            if [ -d ~/.config/dotfiles ]; then
                rm -rf ~/.config/dotfiles
            fi
            if git clone https://github.com/drksch/dotfiles-a.git ~/.config/dotfiles; then
                echo -e ${DM} "Dotfiles cloned successfully."${NC}
                cp -r ~/.config/dotfiles/{starship.toml,font.ttf,fish,fastfetch} ~/.config/
                sleep 1
                mv ~/.config/font.ttf ~/.termux/
            else
                echo -e ${DM} "Error cloning dotfiles. Please check the Git output for more information."${NC}
            fi
            ;;
        "No")
            echo -e ${DM} "Dotfiles and other tools not installed."${NC}
            ;;
    esac
    break
done

# Prompt to install Fish shell
echo -e ${DM} "Would you like to install Fish shell?"${NC}
select fish_choice in "Yes" "No"; do
    case $fish_choice in
        "Yes")
            # Install Fish, Starship, Tealdeer, and Fastfetch
            if pkg install -y fish starship tealdeer fastfetch; then
                echo -e ${DM} "Fish, Starship, Tealdeer, and Fastfetch installed successfully."${NC}
            else
                echo -e ${DM} "Error installing Fish, Starship, Tealdeer, and Fastfetch. Please check the package manager output for more information."${NC}
            fi
            ;;
        "No")
            echo -e ${DM} "Fish shell not installed."${NC}
            ;;
    esac
    break
done

echo -e ${DM} "You are now ready to start your journey. [Termux Setup Complete]"${NC}
sleep 3

termux-reload-settings
echo -e ${DM} "But......"${NC}
sleep 3

# Prompt to install Oh-my-fish
echo -e ${DM} "Would you like to install Oh-my-fish?"${NC}
select ohmyfish_choice in "Yes" "No"; do
    case $ohmyfish_choice in
        "Yes")
            if curl -fsSL https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish; then
                echo -e ${DM} "Oh-my-fish installed successfully."${NC}
                cp -r ~/.config/dotfiles/omf ~/.config/
            else
                echo -e ${DM} "Error installing Oh-my-fish. Please check the installation output for more information."${NC}
            fi
            ;;
        "No")
            echo -e ${DM} "Oh-my-fish not installed."${NC}
            ;;
    esac
    break
done

