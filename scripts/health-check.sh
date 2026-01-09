#!/bin/bash
# =============================================================================
# health-check.sh - System Health Check Script for Homelab
# =============================================================================
# Reports system health metrics including:
#   - Hostname and uptime
#   - CPU and memory usage
#   - Disk usage for root partition
#   - Docker container status (if available)
#   - Recent system log entries
# =============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print section header
print_header() {
    echo -e "\n${BLUE}=== $1 ===${NC}"
}

# Print status line
print_status() {
    echo -e "${GREEN}$1${NC}"
}

# =============================================================================
# Hostname and Uptime
# =============================================================================
print_header "System Information"
echo "Hostname: $(hostname)"
echo "Uptime:   $(uptime -p)"
echo "Date:     $(date)"

# =============================================================================
# CPU Usage
# =============================================================================
print_header "CPU Usage"
# Get CPU usage from top (1 iteration, batch mode)
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'%' -f1)
cpu_used=$(echo "100 - $cpu_idle" | bc 2>/dev/null || echo "N/A")
echo "CPU Usage: ${cpu_used}%"

# Show load averages
echo "Load Avg:  $(cat /proc/loadavg | awk '{print $1, $2, $3}')"

# =============================================================================
# Memory Usage
# =============================================================================
print_header "Memory Usage"
free -h | grep -E "^(Mem|Swap):" | while read line; do
    echo "$line"
done

# Calculate memory percentage
mem_total=$(free | grep Mem | awk '{print $2}')
mem_used=$(free | grep Mem | awk '{print $3}')
mem_percent=$(echo "scale=1; $mem_used * 100 / $mem_total" | bc 2>/dev/null || echo "N/A")
echo "Memory Used: ${mem_percent}%"

# =============================================================================
# Disk Usage (Root Partition)
# =============================================================================
print_header "Disk Usage (Root Partition)"
df -h / | tail -1 | awk '{printf "Total: %s, Used: %s (%s), Available: %s\n", $2, $3, $5, $4}'

# =============================================================================
# Docker Container Status
# =============================================================================
print_header "Docker Status"
if command -v docker &> /dev/null; then
    if docker info &> /dev/null; then
        # Count containers by status
        running=$(docker ps -q | wc -l)
        total=$(docker ps -aq | wc -l)
        echo "Containers: $running running / $total total"

        # List running containers
        if [ "$running" -gt 0 ]; then
            echo ""
            echo "Running containers:"
            docker ps --format "  - {{.Names}}: {{.Status}}" 2>/dev/null
        fi
    else
        echo -e "${YELLOW}Docker daemon not accessible (permission denied or not running)${NC}"
    fi
else
    echo -e "${YELLOW}Docker not installed${NC}"
fi

# =============================================================================
# Recent System Logs
# =============================================================================
print_header "Recent System Logs (last 5 entries)"
if [ -f /var/log/syslog ]; then
    tail -5 /var/log/syslog 2>/dev/null || echo "Unable to read syslog"
elif [ -f /var/log/messages ]; then
    tail -5 /var/log/messages 2>/dev/null || echo "Unable to read messages"
else
    # Try journalctl as fallback
    if command -v journalctl &> /dev/null; then
        journalctl -n 5 --no-pager 2>/dev/null || echo "Unable to read journal"
    else
        echo "No accessible system log found"
    fi
fi

# =============================================================================
# Summary
# =============================================================================
print_header "Health Check Complete"
echo "Timestamp: $(date -Iseconds)"
