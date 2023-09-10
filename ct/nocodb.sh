#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/tteck/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2023 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
    _   __                 ____  ____ 
   / | / /___  ____  ___  / __ \/ __ )
  /  |/ / __ \/ ___/ __ \/ / / / __  |
 / /|  / /_/ / /__/ /_/ / /_/ / /_/ / 
/_/ |_/\____/\___/\____/_____/_____/  
 
EOF
}
header_info
echo -e "Loading..."
APP="NocoDB"
var_disk="4"
var_cpu="1"
var_ram="1024"
var_os="debian"
var_version="11"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function update_script() {
header_info
if [[ ! -f /etc/systemd/system/nocodb.service ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
msg_info "Updating ${APP}"
cd /opt/nocodb
npm uninstall -s --save nocodb &>/dev/null
npm install -s --save nocodb &>/dev/null
systemctl restart nocodb.service
msg_ok "Updated Successfully"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${APP} should be reachable by going to the following URL.
         ${BL}http://${IP}:8080/dashboard${CL} \n"