#! /bin/bash

timestamp=$(date "+%Y-%m-%d %H:%M:%S")

echo "System Monitoring Alert - $timestamp"
echo
echo "System Monitoring Report - $timestamp"
echo "======================================"
echo
mydesk=$(df -h | grep "/dev/nvme0n1p6" | awk '{print $5}')
echo "Disk usage : $mydesk"
echo

mycpuUsage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
echo "Current CPU usage: $mycpuUsage"
echo

memory=$(free -h | grep "Mem")
total=$(echo $memory | awk '{print $2}')
used=$(echo $memory | awk '{print $3}')
free=$(echo $memory | awk '{print $4}')

echo 
echo "memory usage"
echo "total memory: $total"
echo "used memory: $used"
echo "free memory: $free"

echo ""
echo "Top 5 Memory-Consuming Processes:"
ps aux --sort=-%mem | awk '{print $2,$1,$4,$NF}' | head -n 6


