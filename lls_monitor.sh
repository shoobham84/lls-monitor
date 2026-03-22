#!/bin/zsh

CPU_LIMIT=${MONITOR_LIMIT:-5.0}
MEM_LIMIT=${MONITOR_MEM_LIMIT:-80.0}

echo "Starting LLS monitor with CPU limit $CPU_LIMIT% and MEM limit $MEM_LIMIT%"
echo "PID: $$"
echo "--------------------------------------------------"

LOCK_FILE="$HOME/.lls_monitor.lock"

exec 9> "$LOCK_FILE"
if ! flock -n 9; then
    echo "Error: LLS Monitor already running in background. Check background jobs"
    exit 1
fi

cleanup() {
    echo "Termination signal. Shutting down-------"
    pkill -P $$
    exit 0
}

trap cleanup SIGINT SIGTERM 

while true; do
    echo "[$(date +'%H-%M-%S')] running diagnostics"

    awk -v limit="$CPU_LIMIT" '/^cpu / {
        idle = $5;
        total = 0;
        for (i = 2; i<=NF; ++i) {
            total += $i;
        }
        cpu_usage = 100*(1-(idle/total));
        
        if (cpu_usage > limit) {
            printf "HIGH System CPU: %.1f%%\n", cpu_usage
        }
        else {
            printf "System CPU: %.1f%%\n", cpu_usage
        }
    }' /proc/stat
    
    free -m | awk -v limit="$MEM_LIMIT" 'NR==2 {
        percent = $3/$2 * 100;
        if (percent > limit) {
            printf "HIGH System RAM: %.1f%%\n", percent
        }
        else {
            printf "System RAM: %.1f%%\n", percent
        }
    }' 

    echo "------------------------------------------------"

    sleep 5 
done
