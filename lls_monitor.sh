#!/bin/zsh

CPU_LIMIT=${MONITOR_LIMIT:-5.0}

echo "Starting LLS monitor with CPU limit $CPU_LIMITl%"
echo "PID: $$"
echo "--------------------------------------------------"

if [ $(pgrep -cf "lls_monitor.sh") -gt 1]; then
    echo "Error: LLS Monitor already running in background. Check background jobs"
    echo exit 1
fi

while true; do
    echo "[$(date +'%H-%M-%S')] running diagnostics"
    sleep 10
done
