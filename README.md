# RPi-setup

| Ubuntu               | Architecture | Status                                                                                                                                                           |
| -------------------- | ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Debian GNU/Linux 12  | arm64        |  **Passing**                                                                                                                                                     |

## Core Submodules
- [Profile manager](https://github.com/klaxalk/profile_manager) handles the automatic switching of profiles in config files based on a predefined set of keywords for which uses [epigen](https://github.com/klaxalk/epigen).
- [tmux](https://github.com/tmux/tmux) is a terminal multiplexer.  It enables a number of terminals to be created, accessed, and controlled from a single screen. ...
- [Tmuxinator](https://github.com/tmuxinator/tmuxinator) creates and manage tmux sessions easily. ...
- [ranger](https://github.com/ranger/ranger) is a console file manager with VI key bindings. ...
- [Vim](https://github.com/vim/vim.git) is a greatly improved version of the good old UNIX editor Vi. ...
     * [vim-plug](https://github.com/junegunn/vim-plug) a minimalist Vim plugin manager.

## Custom configurations at *appconfig*
- **bash**
   * dotbashrc*
- **tmux**
   * [https://github.com/klaxalk/linux-setup/wiki/tmux](https://github.com/klaxalk/linux-setup/wiki/tmux)
   * ~/.tmux.conf 
- **tmuxinator**
- **vim**
   * /dotvim/pluginconfig/vim-startify*
   * /dotvim/pluginconfig/vim/clang-format*
   * /dotvim/pluginconfig/vim/vim_wiki* TODO:
- **shell**
   * includes a basic set of aliases used in [MRS](https://github.com/ctu-mrs).
- **profile_manager**
   * file_list.txt
- **ranger** 
   * rc.conf*
 
## Vim plugins
+ [jellybeans.vim](https://github.com/nanotech/jellybeans.vim) a colorful, dark color scheme, inspired by ir_black and twilight.
+ [fugitive.vim](https://github.com/tpope/vim-fugitive) is the premier Vim plugin for Git. Or maybe it's the premier Git plugin for Vim? ...
+ [vim-dispatch](https://github.com/tpope/vim-dispatch)
+ vim-gitgutter is showing git changes in the file
+ vim-conflicted is resolving conflicts in git the better way
+ vim-rainbow
+ vim-airline
+ vim-airline-themes
+ lambdalisue/suda.vim  is for saving files with sudo from normal vim
+ benmills/vimux is integration with tmux (allows running bash commands in tmux splits)
+ scrooloose/nerdtree is file manager (leader+n)
+ mhinz/vim-startify is home screen
+ kshenoy/vim-signature shows marks left to line numbers
+ tpope/vim-abolish clever abbreviations and syntax conversion
+ foosoft/vim-argwrap automatic function argument reformatting (leader+w)
+ hynek/vim-python-pep8-indent python formatting
+ unblevable/quick-scope is clever motions helper (highlights letters while using f, t motions)
+ majutsushi/tagbar Shows tags in the file
+ ycm-core/YouCompleteMe
+ rdnetto/YCM-Generator
+ and other I did not have time to go through everything (just look at ~/.vimrc)

# rpi cheat-sheet

## Backuping RPI's SD card
- [https://raspberrypi.stackexchange.com/questions/311/how-do-i-backup-my-raspberry-pi](https://raspberrypi.stackexchange.com/questions/311/how-do-i-backup-my-raspberry-pi)
- [https://github.com/framps/raspiBackup](https://github.com/framps/raspiBackup)

## Wireless Local Area Network

### Setup Wi-Fi to connect automatically
I used these guides 
- [https://raspberrypihq.com/how-to-connect-your-raspberry-pi-to-wifi/](https://raspberrypihq.com/how-to-connect-your-raspberry-pi-to-wifi/)
- [https://weworkweplay.com/play/automatically-connect-a-raspberry-pi-to-a-wifi-network/](https://weworkweplay.com/play/automatically-connect-a-raspberry-pi-to-a-wifi-network/)

+ ip: 192.168.1.111 (was assigned by the router now)
+ Login: telemetry
+ Password: telemetry

### Raspberry Pi Automatic Hotspot and Static Hotspot Installer
The RPi Autohotspot was made according [this](https://www.raspberryconnect.com/projects/65-raspberrypi-hotspot-accesspoints/183-raspberry-pi-automatic-hotspot-and-static-hotspot-installer) guide.

+ ip: 10.0.0.5
+ Login: telemetry
+ Password: telemetry

### Driver for rtl88x2bu wifi adaptors
#### To be able build project
firstly install ``` sudo apt-get install linux-headers ```
and then add `arm_64bit=0` in the /boot/config.txt file 
- ``` git clone git@github.com:cilynx/rtl88x2bu.git ```

### Dual Wi-Fi
I don't know if I did it right, but it works. 
The following guide explains how to set up RPi to have one Autohotspot and one wifi dongle that will connect to the network with the internet.
The guide was derived from [here](https://raspberrypi.stackexchange.com/questions/98753/2-wifi-nics-that-each-only-connect-to-one-different-from-each-other-network/98768#98768) and [here](https://raspberrypi.stackexchange.com/questions/37920/how-do-i-set-up-networking-wifi-static-ip-address-on-raspbian-raspberry-pi-os/37921#37921).

TODO: Bohuzel pri setupovani druheho rpi jsem prisel na to ze zrejme zalezi na tom kdy se nastavi static ip addresa v /etc/dhcpcd.conf. Moje pozorovani je takove ze nejdriv tento soubor musi byt bezezmeny pro autohotspot konfigurator. posleze se muze az provest zmena a nastvi wlan1.servicce. Nicmene behem tohoto psledniho kroku sem jeste udelal zmenu v wpa_supplicant-wlan1.conf protoze sem tam mel u jedne z networks uvedeny nejaky popisek (zapomnel sem jak to presne bylo). Tohle je tedy potreba jeste poradne prozkoumat, neb rpobrat s vasikem...

**To make it run you need to change these files:**

1. /etc/wpa_supplicant-wlan1.conf
   ```bash
   ctrl_interface=DIR=/run/wpa_supplicant GROUP=netdev
   update_config=1
   country=CZ
    
   network={
     ssid="HomeNetwork"
     psk="PasswordHomeNet"
     key_mgmt=WPA-PSK
   }
   ```
2. /etc/dhcpc.conf
   ```bash
   interface wlan1
     static ip_address=192.168.8.10/24
     static routers=192.168.8.1
   ```
3. /etc/network/interfaces
   ```bash
   # there is no need to change anything for this configuration
   ```
4. /etc/systemd/network/10-wlan1.network
   ```bash
    [Match]
    Name=wlan1
    [Network]
    LLMNR=no
    DNSSEC=no
    MulticastDNS=yes
    DHCP=yes
   ```


*To check the internet connection run `iwconfig` or eventually `ifconfig` as always*


## Linux setup (source MRS)
```
cd /tmp
echo "mkdir -p ~/git
cd ~/git
sudo apt-get -y install git
git clone https://github.com/klaxalk/linux-setup
cd linux-setup
./install.sh" > run.sh && source run.sh
```
- few packages must be installed 
  ``` sudo apt-get install toilet; sudo apt-get install rubygems ``` and maybe others which I forgot

In the new version of the Linux setup, I had to comment out *python3-clang* in /appconfig/vim/install.sh

### Additional 
- Temperature monitor 
``` 
sudo apt install lm-sensors
```
# TODO:
## VoiceGPT https://www.hackster.io/nickbild/voicegpt-f88f8f
- https://github.com/tatsu-lab/stanford_alpaca
- https://github.com/cocktailpeanut/dalai

## Home assistant
- https://www.home-assistant.io/
- I would like to run home assistant alongside the raspbian but it looks that it is not possible.



## Air Quality Monitor
- https://www.hackster.io/david-gherghita/air-quality-monitor-using-raspberry-pi-4-sps30-and-azure-03cb42
- https://www.laskakit.cz/senserion-sen55-sdn-t-opticky-senzor-kvality-ovzdusi/


# HACKATHON s Vaclavem
- I created 

docker ps
docker compose up -d
docker compose down
