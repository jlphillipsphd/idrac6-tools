#!/bin/sh

export DISPLAY=:99
xvfb-run --auth-file=/Xauthority --server-args="-screen 0 1024x768x24" openbox-session &
x11vnc -forever -display :99 -auth /Xauthority

