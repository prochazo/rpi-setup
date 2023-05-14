# rpi cheat-sheet

## Setup Wi-Fi to connect automatically
- https://raspberrypihq.com/how-to-connect-your-raspberry-pi-to-wifi/
- https://weworkweplay.com/play/automatically-connect-a-raspberry-pi-to-a-wifi-network/

+ ip: 192.168.1.111 (was assigned by the router now)
+ Login: telemetry
+ Password: telemetry

## Raspberry Pi Automatic Hotspot and Static Hotspot Installer
- https://www.raspberryconnect.com/projects/65-raspberrypi-hotspot-accesspoints/183-raspberry-pi-automatic-hotspot-and-static-hotspot-installer

+ ip: 10.0.0.5
+ Login: telemetry
+ Password: telemetry

## Driver for rtl88x2bu wifi adaptors
### To be able build project
firstly install ``` sudo apt-get install linux-headers ```
and then add `arm_64bit=0` in the /boot/config.txt file 
- ``` git clone git@github.com:cilynx/rtl88x2bu.git ```

To check the internet connection run `iwconfig` or eventually `ifconfig` as always


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
