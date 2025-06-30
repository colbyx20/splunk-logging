#!/bin/sh

# Ensure the log directory exists
mkdir -p /logs

while true; do
  echo "$(date) INFO Log from app.log" >> /logs/app.log
  echo "$(date) DEBUG Log from debug.log" >> /logs/debug.log
  sleep 2
done
