#!/bin/bash
sudo apt -y remove ffmpeg
sudo apt update
sudo apt -y install ffmpeg
cd ~/
mkdir ~/ffmpeg_sources
sudo apt -y install build-essential checkinstall git libfaac-dev libgpac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev librtmp-dev libtheora-dev libvorbis-dev pkg-config texi2html yasm zlib1g-dev libx264-dev libx265-dev libfdk-aac-dev libmp3lame-dev libopus-dev libass-dev libnuma-dev
cd ~/ffmpeg_sources && 
wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && 
tar xjvf ffmpeg-snapshot.tar.bz2 && 
cd ffmpeg && \
PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="$HOME/ffmpeg_build" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$HOME/ffmpeg_build/include" \
  --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
  --extra-libs="-lpthread -lm" \
  --enable-gpl \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libvorbis \
  --enable-libx264 \
  --enable-libx265 \
  --enable-nonfree 
make -j4
make install && \
hash -r
sudo mv /usr/bin/ffmpeg /usr/bin/ffmpeg_old
sudo cp ~/ffmpeg_sources/ffmpeg/ffmpeg /usr/bin/
sudo rm -rf ~/ffmpeg_sources/
sudo rm -rf ~/ffmpeg_build/
