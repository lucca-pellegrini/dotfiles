#!/usr/bin/env bash

dir="$HOME/.config/rofi/launchers/type-4"
theme='style-9'

## Run
rofi \
    -dmenu \
    -theme ${dir}/${theme}.rasi
