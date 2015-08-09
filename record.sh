#!/bin/bash
filename=${1-screencast}

width=1280
height=720
y=100
x=100

vagrant up

(terminator --geometry=${width}x${height}+${x}+${y} --borderless -x vagrant ssh; killall recordmydesktop )&
[[ -e /usr/bin/guake ]] && /usr/bin/guake --hide
sleep 5
mplayer /usr/share/sounds/freedesktop/stereo/bell.oga
recordmydesktop --fps 30 --width=${width} --height=${height} -x ${x} -y ${y} -o "$filename"
ffmpeg-static -i "$filename" -c:v huffyuv -c:a pcm_s16le output.mkv
