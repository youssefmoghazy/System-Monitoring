#!/bin/bash

# Default values
threshold=60
output_file="/home/youssef/System-Monitoring/monitringLog"

# Function to display usage
usage() {
  echo "Usage: $0 [-t threshold] [-f output_file]"
  echo "  -t threshold   Set the disk usage warning threshold (default: 60%)"
  echo "  -f output_file Set the output file name (default: /home/youssef/System-Monitoring/monitringLog)"
  exit 1
}

# Parse command-line options
while getopts ":t:f:" opt; do
  case $opt in
    t) threshold=$OPTARG ;;
    f) output_file=$OPTARG ;;
    *) usage ;;
  esac
done

# Get current timestamp
timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Start logging
{
    # Start HTML document
    echo "<html>"
    echo "<head><title>System Monitoring Report</title></head>"
    echo "<body>"
    echo "<h1>System Monitoring Alert - $timestamp</h1>"
    echo "<h2>System Monitoring Report - $timestamp</h2>"
    echo "<hr>"

    # Disk usage check
    mydesk=$(df -h | grep "/dev/nvme0n1p6" | awk '{print $5}')
    mydesk=${mydesk//%/}
    echo "<h3>Disk usage: $mydesk%</h3>"
    
    # Check if disk usage exceeds threshold
    if [ "$mydesk" -gt "$threshold" ]; then
        echo "<p style='color:red;'>Disk usage exceeded $threshold%!</p>"
    fi

    # CPU usage
    mycpuUsage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
    echo "<p><strong>Current CPU usage:</strong> $mycpuUsage</p>"

    # Memory usage
    memory=$(free -h | grep "Mem")
    total=$(echo $memory | awk '{print $2}')
    used=$(echo $memory | awk '{print $3}')
    free=$(echo $memory | awk '{print $4}')
    echo "<h3>Memory usage</h3>"
    echo "<p><strong>Total memory:</strong> $total</p>"
    echo "<p><strong>Used memory:</strong> $used</p>"
    echo "<p><strong>Free memory:</strong> $free</p>"

    # Top 5 memory-consuming processes
    echo "<h3>Top 5 Memory-Consuming Processes:</h3>"
    echo "<table border='1'>"
    echo "<tr><th>PID</th><th>User</th><th>% MEM</th><th>Command</th></tr>"
    ps aux --sort=-%mem | awk '{print "<tr><td>"$2"</td><td>"$1"</td><td>"$4"</td><td>"$NF"</td></tr>"}' | head -n 6
    echo "</table>"

    # End HTML document
    echo "</body>"
    echo "</html>"
} > "$output_file"
# Send email if disk usage exceeds threshold
if [ "$mydesk" -gt "$threshold" ]; then
    {
        echo "Subject: Disk Usage Alert"
        echo "Content-Type: text/html"
        echo ""
        echo ""
        echo "<h3>System Monitoring Report:</h3>"
	cat "$output_file" 
    } | sendmail youssefmoghazy16@gmail.com
fi
