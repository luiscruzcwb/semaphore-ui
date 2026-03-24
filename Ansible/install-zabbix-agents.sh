#!/bin/bash
# Run this script on the Proxmox host (192.168.18.165) as root
# It installs zabbix-agent2 on all LXC containers that don't have it yet

ZABBIX_SERVER="192.168.18.203"

declare -A VMS=(
  [100]="vm-prom-winexport"
  [101]="vm-semaphore"
  [104]="vm-vault"
  [105]="vm-heimdall"
  [106]="vm-npm"
  [111]="vm-grav"
  [112]="vm-authentik"
  [114]="vm-adguard"
  [115]="vm-awx"
  [116]="vm-puc-devops"
)

for vmid in "${!VMS[@]}"; do
  hostname="${VMS[$vmid]}"
  echo "=== Installing zabbix-agent2 on VMID $vmid ($hostname) ==="
  
  # Check OS
  os=$(pct exec $vmid -- cat /etc/os-release 2>/dev/null | grep PRETTY_NAME | cut -d'"' -f2)
  echo "  OS: $os"
  
  # Install zabbix-agent2
  pct exec $vmid -- bash -c "
    apt-get update -qq && \
    wget -q https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest+ubuntu22.04_all.deb -O /tmp/zabbix-release.deb && \
    dpkg -i /tmp/zabbix-release.deb && \
    apt-get update -qq && \
    apt-get install -y -qq zabbix-agent2 && \
    sed -i 's/^Server=.*/Server=$ZABBIX_SERVER/' /etc/zabbix/zabbix_agent2.conf && \
    sed -i 's/^ServerActive=.*/ServerActive=$ZABBIX_SERVER/' /etc/zabbix/zabbix_agent2.conf && \
    sed -i 's/^Hostname=.*/Hostname=$hostname/' /etc/zabbix/zabbix_agent2.conf && \
    systemctl enable zabbix-agent2 && \
    systemctl restart zabbix-agent2 && \
    echo 'Done!'
  " 2>&1
  
  echo ""
done

echo "All done! Verify with: pct exec <vmid> -- systemctl status zabbix-agent2"
