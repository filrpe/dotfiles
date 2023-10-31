## Automate


~~~bash

## Apps
sudo apt install curl git htop gparted tilix neofetch geany flameshot nautilus rofi picom python3-pip pavucontrol gcc firefox qcalc blueman pulsemixer ranger nitrogen vim neovim wget lm_sensors lxappearance gimp build-essential libpam0g-dev libxcb-xkb-dev mlocate mpv pango pamixer qalculate shotwell steam xcalc xrandr xclip xprop zathura-pdf-poppler translate-shell fzf w3m-img apt-show-versions fonts-font-awesome awesome awesome-extra meson asciidoc font-manager libncurses5-dev linux-headers-amd64 knotes qimgv libevdev2 libpcre3-dev calc


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

ln -s ~/.dotfiles/.fonts ~/.fonts && ln -s ~/.dotfiles/.gitconfig ~/ && ln -s ~/.dotfiles/.config/* ~/.config/

cd ~/.local/share/ && sudo mkdir rofi
sudo ln -s ~/.dotfiles/.config/rofi/themes/ ~/.local/share/rofi/
sudo ln -s ~/.dotfiles/.config/awesome/themes/ /usr/share/awesome/

## Reload fonts
fc-cache -f -v

## Picom
# dependences
libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev  libpcre2-dev  libevdev-dev uthash-dev libev-dev libx11-xcb-dev

git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build

LDFLAGS="-L/usr/local/include" CPPFLAGS="-I/usr/local/include" meson --buildtype=release . build

ninja -C build install

git clone https://github.com/jonaburg/picom
cd picom
meson --buildtype=release . build
ninja -C build
# To install the binaries in /usr/local/bin (optional)
sudo ninja -C build install


### Install Ly Manager ####
sudo apt install build-essential libpam0g-dev libxcb-xkb-dev
git clone --recurse-submodules https://github.com/fairyglade/ly
cd ly
make
make run
sudo make install installsystemd

desabilite o servico

sudo systemctl disable lightdm.service

habilite o novo

sudo systemctl enable ly.service

#reboot

##### PARA RODAR O :PlugInstall no NVIM
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
Execute no nvim
:PlugInstall


#### ALACRITTY #####

sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

Após o término, será necessário a instalação do compilador Rust, para isso execute o comando abaixo:

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

Agora iremos carregar o arquivo contendo as variáveis de ambiente:

source $HOME/.cargo/env

Realizaremos também a instalação do cargo:

sudo apt-get install cargo

E por fim iremos instalar o Alacritty:

cargo install alacritty

Neste passo, iremos criar os atalhos necessários no seu ambiente gráfico para que você consiga executar o Alacritty, então execute os comandos abaixo:

git clone https://github.com/alacritty/alacritty.git
cd alacritty
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg && sudo desktop-file-install extra/linux/Alacritty.desktop && sudo update-desktop-database

Um passo interessante a se fazer, é realizar a cópia do binário para o local que esteja mapeado em seu PATH, pois dessa forma poderá ser executado de qualquer local.

sudo cp $HOME/.cargo/bin/alacritty /usr/local/bin

Iremos ainda realizar as configurações extras:

mkdir -p ${ZDOTDIR:-~}/.zsh_functions
echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >> ${ZDOTDIR:-~}/.zshrc
cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty

Prontinho, seu terminal alacritty já pode ser executado pelo menu/ícones.

