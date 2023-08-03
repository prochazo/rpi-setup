# rpi cheat-sheet

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

### Additional 
- Temperature monitor 
``` 
sudo apt install lm-sensors
```
# TODO:
## VoiceGPT https://www.hackster.io/nickbild/voicegpt-f88f8f
- https://github.com/tatsu-lab/stanford_alpaca
- https://github.com/cocktailpeanut/dalai

## Air Quality Monitor
- https://www.hackster.io/david-gherghita/air-quality-monitor-using-raspberry-pi-4-sps30-and-azure-03cb42
