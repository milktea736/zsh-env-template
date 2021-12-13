#!/bin/bash

is_running=$(ps aux | grep "[L]"yricsX | awk '{print $2}')

if [[ -z ${is_running} ]]; then
    open /Applications/LyricsX.app
else
    ps aux | grep "[L]"yricsX | awk '{print $2}' | xargs kill
fi