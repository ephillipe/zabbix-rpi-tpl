#!/usr/bin/env bash
# Script for Monitoring a Raspberry Pi with Zabbix
# 2015 Erick Almeida
# ephillipe@gmail.com 
# https://about.me/erick.almeida 
# http://erickalmeida.brandyourself.com/

# Create a folder where the scripts are located
mkdir -p /usr/share/zabbix-agent/scripts/
chown -R zabbix:zabbix /usr/share/zabbix-agent/

# Create a configuration for Zabbix Agent
cp conf/*.conf `cat /etc/zabbix/zabbix_agentd.conf | grep -v "#" | grep Include| awk -F"/" '{print "/"$2"/"$3"/"$4}'`

# Portable executable script
cp scripts/*.sh /usr/share/zabbix-agent/scripts/
chown -R zabbix:zabbix /usr/share/zabbix-agent/scripts
chmod +x /usr/share/zabbix-agent/scripts/*.sh
# Adding a user to a group zabbix video, without it you can not get the GPU temperature
usermod -a -G video zabbix

# Restart Zabbix Agent
service zabbix-agent restart
echo "Installation is complete"
