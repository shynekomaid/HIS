#!/bin/bash/
echo 216 | sudo tee /sys/class/gpio/export
echo out | sudo tee /sys/class/gpio/gpio216/direction
echo 1 | sudo tee /sys/class/gpio/gpio216/value
