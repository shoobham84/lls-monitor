#!/bin/zsh

CPU_LIMIT=${MONITOR_LIMIT:-5.0}

echo "Starting LLS monitor with CPU limit $CPU_LIMIT%"
echo "PID: $$"
echo "--------------------------------------------------"

if [ $(pgrep -cf "lls_monitor.sh") -gt 1 ]; then
    SECURE_TMP=$(mktmp /tmp/lls_monitor.XXXXXX)
    echo "Secure temp file allocated at: $SECURE_TMP"
    echo "Error: LLS Monitor already running in background. Check background jobs"
    exit 1
fi

cleanup() {
    echo "Termination signal. Shutting down-------"
    pkill -P $$

    rm -f "$SECURE_TMP"
    echo "Cleaned up at $SECURE_TMP"
    exit 0
}

trap cleanup SIGINT SIGTERM 

while true; do
    echo "[$(date +'%H-%M-%S')] running diagnostics"
    sleep 5 
done
