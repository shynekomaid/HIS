#!/bin/bash
clear_screen='\033c'

c_BLACK='\033[0;30m'
c_RED='\033[0;31m'
c_GREEN='\033[0;32m'
c_BROWN='\033[0;33m'
c_BLUE='\033[0;34m'
c_PURPLE='\033[0;35m'
c_CYAN='\033[0;36m'
c_LIGHTGRAY='\033[0;37m'

c_DARKGRAY='\033[1;30m'
c_LIGHTRED='\033[1;31m'
c_LIGHTGREEN='\033[1;32m'
c_YELLOW='\033[1;33m'
c_LIGHTBLUE='\033[1;34m'
c_LIGHTPURPLE='\033[1;35m'
c_LIGHTCYAN='\033[1;36m'
c_WHITE='\033[1;37m'

c_NC='\033[0m'

folders_list () {
  u_pwd=$(pwd)
  cd $1
  folders_list=()
  scr_folders=(*)
  scr_folders_count="${#scr_folders[@]}"
  cur_folders=0
  while [ $cur_folders -lt $scr_folders_count ]
  do
    folders_list+=(${scr_folders[$cur_folders]})
    ((cur_folders++))
  done
  cd $u_pwd
  return 0
}

ch1 () {
  folders_list scripts
  echo -e ${clear_screen}${c_LIGHTBLUE}"What do you need to setup?"
  echo
  cur=1
  while [ $cur -le $scr_folders_count ]
  do
    echo -e ${c_BROWN}[${c_LIGHTBLUE}$cur${c_BROWN}] ${c_GREEN}${folders_list[$cur-1]}
    ((cur++))
  done
  echo -e ${c_NC}
  read -p  "> " choose

  if [[ $choose -gt $scr_folders_count ]] || [[ $choose -lt 1  ]] ; then
    ch1
  fi
  return 0
}

ch2 () {
  path=$(pwd)/scripts/${scr_folders[$choose-1]}
  echo $path
  cd $path
  ls
  folders_list $path
}

ch1
ch2
