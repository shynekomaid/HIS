#!/bin/bash
USB="$(ls /dev/ | grep hidraw)"

if [ -z "${USB}" ]
then
      echo "no usb"
else
      echo "fuck you"
      sudo shutdown now
fi
