#!/bin/bash

#=== setup ===
cd
rm -rf /root/udp
mkdir -p /root/udp
rm -rf /etc/UDPCustom
mkdir -p /etc/UDPCustom
udp_dir='/etc/UDPCustom'
udp_file='/etc/UDPCustom/udp-custom'
sudo touch /etc/UDPCustom/udp-custom

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y wget
sudo apt install -y curl
sudo apt install -y dos2unix

source <(curl -sSL 'https://raw.githubusercontent.com/Rerechan02/UDP/main/module/module')

time_reboot() {
  print_center -ama "${a92:-System/Server Reboot In} $1 ${a93:-Seconds}"
  REBOOT_TIMEOUT="$1"

  while [ $REBOOT_TIMEOUT -gt 0 ]; do
    print_center -ne "-$REBOOT_TIMEOUT-\r"
    sleep 1
    : $((REBOOT_TIMEOUT--))
  done
  rm /home/ubuntu/install.sh
  reboot
}

# Check Ubuntu version
if [ "$(lsb_release -rs)" = "8*|9*|10*|11*|16.04*|18.04*" ]; then
  clear
  print_center -ama -e "\e[1m\e[31m=====================================================\e[0m"
  print_center -ama -e "\e[1m\e[33m${a94:-this script is not compatible with your operating system}\e[0m"
  print_center -ama -e "\e[1m\e[33m ${a95:-Use Ubuntu 20 or higher}\e[0m"
  print_center -ama -e "\e[1m\e[31m=====================================================\e[0m"
  rm /home/ubuntu/install.sh
  exit 1
else
  clear
  echo ""
  print_center -ama "A Compatible OS/Environment Found"
  print_center -ama " ⇢ Installation begins...! <"
  sleep 3

  # [+clean up+]
  rm -rf $udp_file &>/dev/null
  rm -rf /etc/UDPCustom/udp-custom &>/dev/null
  rm -rf /usr/bin/udp-request &>/dev/null
  rm -rf /etc/limiter.sh &>/dev/null
  rm -rf /etc/UDPCustom/limiter.sh &>/dev/null
  rm -rf /etc/UDPCustom/module &>/dev/null
  rm -rf /usr/bin/udp &>/dev/null
  rm -rf /etc/UDPCustom/udpgw.service &>/dev/null
  rm -rf /etc/udpgw.service &>/dev/null
  systemctl stop udpgw &>/dev/null
  systemctl stop udp-custom &>/dev/null
  systemctl stop udp-request &>/dev/null

 # [+get files ⇣⇣⇣+]
  source <(curl -sSL 'https://raw.githubusercontent.com/Rerechan02/UDP/main/module/module') &>/dev/null
  wget -O /etc/UDPCustom/module 'https://raw.githubusercontent.com/Rerechan02/UDP/main/module/module' &>/dev/null
  chmod +x /etc/UDPCustom/module

  wget "https://raw.githubusercontent.com/Rerechan02/UDP/main/bin/udp-custom-linux-amd64" -O /root/udp/udp-custom &>/dev/null
  wget "https://raw.githubusercontent.com/Rerechan02/UDP/main/bin/udp-request-linux-amd64" -O /usr/bin/udp-request &>/dev/null
  chmod +x /root/udp/udp-custom
  chmod +x /usr/bin/udp-request

  wget -O /etc/limiter.sh 'https://raw.githubusercontent.com/Rerechan02/UDP/main/module/limiter.sh'
  cp /etc/limiter.sh /etc/UDPCustom
  chmod +x /etc/limiter.sh
  chmod +x /etc/UDPCustom
  
  # [+udpgw+]
  wget -O /etc/udpgw 'https://raw.githubusercontent.com/Rerechan02/UDP/main/module/udpgw'
  mv /etc/udpgw /bin
  chmod +x /bin/udpgw

  # [+service+]
  wget -O /etc/udpgw.service 'https://raw.githubusercontent.com/Rerechan02/UDP/main/config/udpgw.service'
  wget -O /etc/udp-custom.service 'https://raw.githubusercontent.com/Rerechan02/UDP/main/config/udp-custom.service'
  
  mv /etc/udpgw.service /etc/systemd/system
  mv /etc/udp-custom.service /etc/systemd/system

  chmod 640 /etc/systemd/system/udpgw.service
  chmod 640 /etc/systemd/system/udp-custom.service
  
  systemctl daemon-reload &>/dev/null
  systemctl enable udpgw &>/dev/null
  systemctl start udpgw &>/dev/null
  systemctl enable udp-custom &>/dev/null
  systemctl start udp-custom &>/dev/null

  # [+config+]
  wget "https://raw.githubusercontent.com/Rerechan02/UDP/main/config/config.json" -O /root/udp/config.json &>/dev/null
  chmod 644 /root/udp/config.json

  # [+menu+]
  wget -O /usr/bin/udp 'https://raw.githubusercontent.com/Rerechan02/UDP/main/module/udp' 
  chmod +x /usr/bin/udp
  ufw disable &>/dev/null
  apt remove netfilter-persistent -y
  rm -rf /etc/UDPCustom/udp-custom
  print_center -ama "${a103:-setting up, please wait...}"
  sleep 3
  title "${a102:-Installation Successful}"
  print_center -ama "${a103:-  To show menu type: \nudp\n}"
  msg -bar
fi
clear
