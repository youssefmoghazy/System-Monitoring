# System Monitoring Script

This repository contains a shell script that monitors system resources such as disk usage, CPU usage, memory usage, and running processes. The script generates a system report and saves the collected information into a log file. It can also send email alerts when any thresholds are breached.

## Features

- **Disk Usage Monitoring**: Checks the disk usage for each mounted partition and sends a warning if it exceeds a specified threshold.
- **CPU Usage Monitoring**: Displays the current CPU usage percentage.
- **Memory Usage Monitoring**: Shows the total, used, and free memory.
- **Top Processes**: Lists the top 5 memory-consuming processes.
- **Log Generation**: Saves the collected information in a log file (`system_monitor.log`).
- **Email Alerts**: Sends an email if any thresholds (such as disk usage) are breached.
- **Customizable Thresholds and Output**: Allows the user to specify custom thresholds and log file names through command-line arguments.

## Installation

1. **Clone the repository** (if applicable):
   ```bash
   git clone https://github.com/your-username/system-monitoring-script.git
   cd system-monitoring-script

