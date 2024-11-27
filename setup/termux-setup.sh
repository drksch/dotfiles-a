#!/bin/bash

# Check if mirrors have been changed
if [ -f /data/data/com.termux/files/usr/etc/apt/sources.list ]; then
    if grep -q "asia" /data/data/com.termux/files/usr/etc/apt/sources.list; then
        echo "It seems that you have chosen where to start, young adventurer. [Asian Mirror]"
        exit
    fi
fi

# Prompt user to choose the Asian Mirror
echo "Seems you need to start somewhere. May I suggest Arisa?"
select choice in "Yes" "No"; do
    case $choice in
        "Yes")
            termux-change-repo asia
            echo "Wise choice."
            ;;
        "No")
            echo "Then I leave that to you adventurer. If you need help, use the spell
	    termux-change-repo. "
            ;;
    esac
    break
done

echo "Let's upgrade your base system with some added authorization."
pkg upgrade -y
pkg install -y gh which openssh wget
echo "Done...Now it is best to give you starting equipment..:"

# Prompt to install packages
echo "Shall I give you some basic tools. (neovim, git, cmake, stylua, lua-language-server, nodejs)"
select install_choice in "Yes" "No"; do
    case $install_choice in
        "Yes")
            echo "Here you go, adventuer. So tools to help you survive"
            # Gather all non-installed programs in one command
            packages_to_install=$(for package in neovim git cmake stylua lua-language-server nodejs-lts clang; do
                if ! pkg info -I $package >/dev/null 2>&1; then
                    echo -n "$package "
                fi
            done)
            if [ -n "$packages_to_install" ]; then
                pkg install -y $packages_to_install
                echo "I hope these will help you. [Installed: $packages_to_install]"
            else
                echo "Ahh seems you have all the tools."
            fi
            ;;
        "No")
            echo "Hmm..Another time then."
            ;;
    esac
    break
done

    echo "Now you have your grimoire, lets kickstart your journey. I have something here to get you started. Would you like to see?"
    select kickstart_choice in "Yes" "No"; do
        case $kickstart_choice in
            "Yes")
                echo "Conjouring spell Rekindle..."
                if git clone -b android --single-branch https://github.com/drksch/kickstart.nvim.git ~/.config/nvim/; then
                    echo "Rekindle Magic Circle Casted. [Kickstart:Ok]"
                else
                    echo "Strange...Something went wrong."
                fi
                ;;
            "No")
                echo "Rekinde not installed."
                ;;
        esac
        break
    done

# Custom Terminal
# Prompt to install dotfiles and other tools
echo "Would you like to install a custom terminal?"
select dotfiles_choice in "Yes" "No"; do
    case $dotfiles_choice in
        "Yes")
            echo "Installing dotfiles and other tools..."
            # Clone dotfiles repository and copy to ~/.config
            if [ -d ~/.config/dotfiles ]; then
                rm -rf ~/.config/dotfiles
            fi
            if git clone https://github.com/drksch/dotfiles-a.git ~/.config/dotfiles; then
                echo "Dotfiles cloned successfully."
                cp -r ~/.config/dotfiles/{starship.toml,font.ttf,fish,omf} ~/.config/
                sleep 1
                mv ~/.config/font.ttf ~/.termux/
            else
                echo "Error cloning dotfiles. Please check the Git output for more information."
            fi
            ;;
        "No")
            echo "Dotfiles and other tools not installed."
            ;;
    esac
    break
done

# Prompt to install Fish shell
echo "Would you like to install Fish shell?"
select fish_choice in "Yes" "No"; do
    case $fish_choice in
        "Yes")
            # Install Fish, Starship, Tealdeer, and Fastfetch
            if pkg install -y fish starship tealdeer fastfetch; then
                echo "Fish, Starship, Tealdeer, and Fastfetch installed successfully."
            else
                echo "Error installing Fish, Starship, Tealdeer, and Fastfetch. Please check the package manager output for more information."
            fi
            ;;
        "No")
            echo "Fish shell not installed."
            ;;
    esac
    break
done

echo "You are now ready to start your journey. [Termux Setup Complete]"
sleep 5

termux-reload-settings
echo "But......"
sleep 10

echo "Do you want 
# Prompt to install Oh-my-fish
echo "Would you like to install Oh-my-fish?"
select ohmyfish_choice in "Yes" "No"; do
    case $ohmyfish_choice in
        "Yes")
            if curl -fsSL https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish; then
                echo "Oh-my-fish installed successfully."
            else
                echo "Error installing Oh-my-fish. Please check the installation output for more information."
            fi
            ;;
        "No")
            echo "Oh-my-fish not installed."
            ;;
    esac
    break
done

