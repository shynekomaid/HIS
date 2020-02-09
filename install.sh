#!/bin/bash
chmod -R 775 scripts/
upwd=$(pwd)
log() {
    date_now=$(date)
    echo "##$date_now##-> $1" >> $upwd/log.log
}
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

log "start"

folders_list () {
  cd scripts
  folders_list=()
  scr_folders=(*)
  scr_folders_count="${#scr_folders[@]}"
  cur_folders=0
  while [ $cur_folders -lt $scr_folders_count ]
  do
    folders_list+=(${scr_folders[$cur_folders]})
    ((cur_folders++))
  done
  cd ..
  return 0
}

files_list () {
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
  cd ..
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
  read -p  "> " choose1

  if [[ $choose1 -gt $scr_folders_count ]] || [[ $choose1 -lt 1  ]] ; then
    ch1
  else
    path=$upwd/scripts/${scr_folders[$choose1-1]}
    ch2
  fi
  return 0
}

ch2 () {
  echo -e ${clear_screen}${c_LIGHTBLUE}Choosen: ${c_BROWN}${scr_folders[$choose1-1]}
  echo -e ${c_LIGHTBLUE}Path: ${c_BROWN}$path
  files_list $path
  echo
  echo -e ${c_LIGHTBLUE}"Select scripts with its number:"
  echo

  cur=1
  while [ $cur -le $scr_folders_count ]
  do
    echo -e ${c_BROWN}[${c_LIGHTBLUE}$cur${c_BROWN}] ${c_GREEN}${folders_list[$cur-1]}
    ((cur++))
  done
  echo
  echo -e ${c_LIGHTBLUE}Send ${c_GREEN}nums ${c_LIGHTBLUE}to ${c_GREEN}run scripts${c_LIGHTBLUE}, eg. ${c_GREEN}1 2 4${c_LIGHTBLUE} to run ${c_GREEN}1s 2s 4s ${c_LIGHTBLUE}scripts, ${c_RED}q ${c_LIGHTBLUE}to ${c_RED}exit${c_LIGHTBLUE}, ${c_CYAN}b ${c_LIGHTBLUE}to ${c_CYAN}back${c_LIGHTBLUE}, ${c_YELLOW}a ${c_LIGHTBLUE}to ${c_YELLOW}run all${c_LIGHTBLUE}.
  echo -e ${c_NC}
  read -p  "> " choose2

  IFS=' ' read -r -a input <<< "$choose2"
  for launch in "${input[@]}"
  do
    if [[ $launch == "b" ]]; then
      ch1
    fi
    if [[ $launch == "q" ]]; then
      echo "Exiting"
      exit
    fi
    if [[ $launch == "a" ]]; then
      cur=1
      while [ $cur -le $scr_folders_count ]
      do
        launch $cur
        ((cur++))
      done
      exit 0
    fi
    launch $launch
  done
  exit
}

launch () {
  echo -e ${c_LIGHTRED}launch${c_LIGHTGREEN} $path/${folders_list[$1-1]}${c_NC}
  sudo $path/${folders_list[$1-1]} &&
  if [[ $? -eq 0 ]]; then
    echo -e ${c_LIGHTBLUE}Exit code for${c_LIGHTGREEN} ${folders_list[$1-1]} ${c_LIGHTBLUE}is$c_YELLOW 0 ${c_NC}
    log "Exit code for ${folders_list[$1-1]} is 0"
    echo
    return 0
  fi
  echo -e ${c_LIGHTBLUE}Exit code for${c_LIGHTGREEN} ${folders_list[$1-1]} ${c_LIGHTBLUE}is ${c_LIGHTRED}NO ${c_YELLOW}0 ${c_NC}
  log "WARNING: Exit code for ${folders_list[$1-1]} is NO 0"
  echo
}

ch1
ch2
