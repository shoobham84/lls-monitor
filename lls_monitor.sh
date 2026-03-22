#!/bin/zsh

CPU_LIMIT=${MONITOR_LIMIT:-5.0}

echo "Starting LLS monitor with CPU limit $CPU_LIMITl%"
echo "PID: $$"
echo "--------------------------------------------------"

while true; do
    echo "[$(date +'%H-%M-%S')] running diagnostics"
    sleep 10
done
