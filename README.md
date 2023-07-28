## Automate


~~~bash

## Apps
sudo apt install curl git htop gparted tilix neofetch geany flameshot nautilus rofi picom python3-pip pavucontrol gcc firefox qcalc blueman pulsemixer ranger nitrogen vim neovim wget lm_sensors lxappearance gimp build-essential libpam0g-dev libxcb-xkb-dev mlocate mpv pango pamixer qalculate shotwell steam xcalc xrandr xclip xprop zathura-pdf-poppler translate-shell fzf w3m-img apt-show-versions fonts-font-awesome awesome awesome-extra

## Install zsh
sudo apt install zsh && zsh

## Install oh-my-zsh!
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Install autosuggestions && highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

## Links
rm ~/.zshrc &&
ln -s ~/.dotfiles/.zshrc ~/.zshrc

ln -s ~/.dotfiles/.fonts ~/.fonts &&
ln -s ~/.dotfiles/.gitconfig ~/ &&
ln -s ~/.dotfiles/.config/* ~/.config/ &&

cd ~/.local/share/ && sudo mkdir rofi
sudo ln -s ~/.dotfiles/.config/rofi/themes/ ~/.local/share/rofi/

sudo ln -s ~/.dotfiles/.config/awesome/themes/ /usr/share/awesome/

## Reload fonts
fc-cache -f -v


~~~
