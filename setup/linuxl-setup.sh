#!/bin/bash

#This for use with ArchBang.
#As of November 2024 it seems pretty good out of the box.
#Aiming to use this for Ultrabooks 

# 00. Colors
DM='\033[35;1;4m'
NC='\033[0m'
##################################################################################################################
#tput setaf 0 = black
#tput setaf 1 = red
#tput setaf 2 = green
#tput setaf 3 = yellow
#tput setaf 4 = dark blue
#tput setaf 5 = purple
#tput setaf 6 = cyan
#tput setaf 7 = gray
#tput setaf 8 = light blue
##################################################################################################################

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))

# 1. Prereqs:
echo -e ${DM}"Pacman Init?"${NC}
select pacman_init in "Install" "Skip"; do
    case $pacman_init in
        "Install")
            sudo pacman-key --init
            sudo pacman-key --populate
            sudo pacman -Syyu archlinux-keyring
        ;;
        "Skip")
            echo -e ${DM} "Skipping Pacman init. [Skip]"${NC}
        ;;
    esac
    break
done

#Install chaotic aur
echo -e ${DM}"ChaoticAur?"${NC}
select chaotic_aur in "Yes" "No"; do
    case $chaotic_aur in
        "Yes")
            sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
            sudo pacman-key --lsign-key 3056513887B78AEB
            sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
            sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
            sleep 2
        echo -e "[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
        ;;
        "No")
            echo -e ${DM} "You will need to install ChaoticAur manually. [Skipped]"${NC}
        ;;
    esac
    break
done

#Needed Installs
sudo pacman -Syyu
sleep 2
echo -e ${DM}"Remove Firefox"${NC}
sudo pacman -Rcns firefox --noconfirm
sleep 3
echo -e ${DM} "Installing needed packages"${NC}

sudo pacman -Sc --noconfirm
sleep 2

if grep -q "chaotic-aur" /etc/pacman.conf; then
  echo -e "${DM}Chaotic AUR is installed, installing AUR based tools...."${NC}
  #Base Downloads
  sudo pacman -S --noconfirm --needed yay
  sudo pacman -S --noconfirm --needed wget
  sudo pacman -S --noconfirm --needed git
  sudo pacman -S --noconfirm --needed pacseek
  sudo pacman -S --noconfirm --needed npm
  #sudo pacman -S --noconfirm --needed unzip
  sudo pacman -S --noconfirm --needed clang
  sudo pacman -S --noconfirm --needed ghostty
  #fonts
  sudo pacman -S --noconfirm --needed ttf-intone-nerd 
  sudo pacman -S --noconfirm --needed ttf-luciole 
  sudo pacman -S --noconfirm --needed ttf-atkinson-hyperlegible
  #browser
  #sudo pacman -S --noconfirm --needed zen-browser-bin
  #sudo pacman -S --noconfirm --needed palemon-bin
  #sudo pacman -S --noconfirm --needed arch-palemoon-search
else
  echo "Chaotic AUR is not installed, skipping...."
  sleep 2
  # Check if yay is installed
  if ! command -v yay &> /dev/null; then
    echo -e "${DM}Yay is not installed, installing...${NC}"
    sudo pacman -S --noconfirm --needed git go base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -sir --noconfitm
    cd ..
    rm -rf yay
  else
    echo -e "${DM}Yay is already installed.${NC}"
  fi
  sudo yay -S --noconfirm pacseek ttf-intone-nerd ttf-luciole ttf-atkinson-hyperlegible zen-brower-bin arch-palemoon-search palemoon clang
fi

echo -e ${DM}"Install Basic Workflow?"${NC}
select install_choice in "Install" "Skip"; do
    case $install_choice in
        "Install")
            echo -e ${DM} "Installing Tools. Downloading...."${NC}
            # Gather all non-installed programs in one command
            PKG_INSTALL=(
                bat
                eza
                fd
                fzf
                gcc
                gh
                ghq
                gittyup
                make
                neovim
                ripgrep
                unzip
                meld
            )
            for package in "${PKG_INSTALL[@]}"; do
                if ! pkg info -I $package >/dev/null 2>&1; then
                    sudo pacman -S --noconfirm --needed $package
                fi
            done
                ;;
        "Skip")
            echo -e ${DM}"Hmm..Another time then."${NC}
            ;;
    esac
    break
done

echo -e ${DM} "Install Kickstart"${NC}
    select kickstart_choice in "Yes" "No"; do
        case $kickstart_choice in
            "Yes")
                echo -e ${DM} "Conjouring spell Rekindle..."${NC}
                if git clone -b master --single-branch https://github.com/drksch/kickstart.nvim.git ~/.config/nvim/; then
                    echo -e ${DM} "Kickstart: Installed"${NC}
                else
                    echo -e ${DM} "Strange...Something went wrong."${NC}
                fi
                ;;
            "No")
                echo -e ${DM} "Kickstart Not Installed."${NC}
                ;;
        esac
        break
    done
sleep 2

#install tuigreet
echo -e ${DM} "Install Tui Greeter?"${NC}
select greeter_tui in "Install" "Skip"; do
    case $greeter_tui in
        "Install")
            sudo pacman -S --noconfirm --needed greetd-tuigreet
            sudo mkdir -m 755 -v /etc/greetd
            sleep 1
            cd $installed_dir
            echo $installed_dir
            sleep 5
            sudo mv -fi config.toml  /etc/greetd/
            sudo systemctl enable -f greetd.service
        ;;
        "Skip")
            echo -e ${DM} "Skipping Tui Greeter. [Skip]"${NC}
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
            if sudo pacman -S --noconfirm --needed fish starship tealdeer fastfetch
            curl -sSfL https://raw.githubusercontent.com/iffse/pay-respects/main/install.sh | sh; then
                echo -e ${DM}"Fish, Starship, tldr, and Fastfetch installed successfully."${NC}
            else
                echo -e ${DM}"Error installing Fish, Starship, tldr, and Fastfetch. Please check the package manager output for more information."${NC}
            fi
            ;;
        "No")
            echo -e ${DM} "Fish shell not installed."${NC}
            ;;
    esac
    break
done

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
                rm ~/.config/font.tff 
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

#"Setting Environment Variables"
#if | grep -q "XDG_CURRENT_DESKTOP" $HOME/.config/openbox/environment; then
#       echo -e ${NEWLINEVAR} | sudo tee -a $HOME/.config/openbox/environment
#        echo "EDITOR=${TERM}" | sudo tee -a $HOME/.config/openbox/environment
#        echo "BROWSER=zen-browser" | sudo tee -a $HOME/.config/openbox/environment
#    fi
#else
#    if | grep -q "XDG_CURRENT_DESKTOP" $HOME/.config/openbox/environment; then
#        echo -e ${NEWLINEVAR} | sudo tee -a etc/environment
#        echo "EDITOR=${TERM}" | sudo tee -a etc/environment
#        echo "BROWSER=zen-browser" | sudo tee -a etc/environment
#    fi
#



# Prompt to install Oh-my-fish
echo -e ${DM} "Would you like to install Oh-my-fish?"${NC}
select ohmyfish_choice in "Yes" "No"; do
    case $ohmyfish_choice in
        "Yes")
            if curl -fsSL https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish; then
                echo -e ${DM} "Oh-my-fish installed successfully."${NC}
                #cd $installed_dir
                #reecho $installed_dir
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
