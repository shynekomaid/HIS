#!/bin/bash
sudo apt -y update && sudo apt -y upgrade
sudo apt -y remove vsftpd
sudo apt -y install vsftpd
sudo touch /etc/vsftpd.conf
sudo echo "listen=YES
listen_ipv6=NO
write_enable=YES
local_umask=022
idle_session_timeout=600
data_connection_timeout=120
chroot_local_user=YES
allow_writeable_chroot=YES
ls_recurse_enable=YES
pam_service_name=ftp
utf8_filesystem=YES
userlist_enable=YES
userlist_deny=NO" > /etc/vsftpd.conf
sudo touch /etc/vsftpd.user_list
sudo echo "bitrek
dvr
shyneko
"> /etc/vsftpd.user_list
sudo mkdir /photos
