#!/bin/bash

pid=$(ps aux --sort=-%mem |
  tail -n +2 |
  awk '{ cmd = substr($0, index($0,$11)); print $1, $2, cmd }' |
  wofi --dmenu --prompt "Kill PID:" |
  awk '{ print $2 }'
)

if [[ -z "$pid" ]]; then
  exit 0
fi

kill -9 $pid
