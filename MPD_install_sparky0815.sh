#!/bin/sh

##
## MPD install script
##
## Christian Laux
## 2015-02-15
## Version: 0.4
##

color() {
# You can use these codes:

# Black        0;30     Dark Gray     1;30
# Blue         0;34     Light Blue    1;34
# Green        0;32     Light Green   1;32
# Cyan         0;36     Light Cyan    1;36
# Red          0;31     Light Red     1;31
# Purple       0;35     Light Purple  1;35
# Brown/Orange 0;33     Yellow        1;33
# Light Gray   0;37     White         1;37

# And then use them like this in your script:

green='\033[0;32m'
red='\033[0;31m'
yellow='\033[1;33m'
NC='\033[0m' # No Color

#echo -e "${red}Hello Stackoverflow${NC}"
}




Header() {
color
clear
echo "${yellow}MPD auto installer by Christian Laux aka www.sparky0815.de / @sparky0815${NC}"
echo
}


UpdateSystem() {
## update system
color
echo
echo "${red}System will be updated. This can take a few minutes...${NC}"
echo
sudo apt-get -qq update && sudo apt-get -qq -y upgrade
echo "${green}System updated...${NC}"
}


InstallMPD() {
## install mpd and tools
color
echo 
echo "${red}MPD will be installed. This can take a few minutes...${NC}"
echo
sudo apt-get -qq -y install mpd mpc alsa-utils usbmount ntfs-3g
echo "${green}Software installed...${NC}"
}

StartALSA() {
## start alsa
color
echo
echo "${red}Start Audio-Device...${NC}"
echo
sudo modprobe snd-bcm2835
echo "${green}Audio device startet...${NC}"
}

SetAudioOutput() {
## set output to 3,5mm audio jack
## amixer cset numid=3 <number> (number = see below)
echo 
echo "0 = auto"
echo "1 = 3,5mm audio jack (analog)"
echo "2 = HDMI (digital)"
echo "Please choose audio output (0, 1 oder 2)"
echo

## Test mit case
read answer
case $answer in

  0*) 
color
echo
echo "${red}Audio output will be set to 'auto' ...${NC}"
echo
sudo amixer cset numid=3 $answer
unset answer
echo
echo "${green}Audio output configured...${NC}"
echo
echo "${green}Done! Please configure /etc/mpd.conf and restart your system !${NC}"
echo
;;

  1*) 
color
echo
echo "${red}Audio output will be set to '3,5mm audio jack (analog)' ...${NC}"
echo
sudo amixer cset numid=3 $answer
unset answer
echo
echo "${green}Audio output configured...${NC}"
echo
echo "${green}Done! Please configure /etc/mpd.conf and restart your system !${NC}"
echo
;;

  2*)
color
echo
echo "Audio output will be set to 'HDMI (digital)' ..."
echo
sudo amixer cset numid=3 $answer
unset answer
echo
echo "${green}Audio output configured...${NC}"
echo
echo "${green}Done! Please configure /etc/mpd.conf and restart your system !${NC}"
echo
;;

  *) 
color
echo
echo "${red}Abort! Please start script again!${NC}"
exit 0
;;

esac
}

#GetConfig() {
## get my pre-configured mpd.conf
## cd /etc
## sudo wget http://46.38.241.69/own/mpd.conf
#}

Header
UpdateSystem
InstallMPD
StartALSA
SetAudioOutput
