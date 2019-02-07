#!/bin/bash
# Installing zabbix agent on XenServer 7.2

echo "Chahge default route..."
ip route replace default via 192.168.120.152

echo "Install zabbix-agent..."
rpm -i https://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-agent-3.4.15-1.el7.x86_64.rpm

echo "Configuration iptables..."
cat <<EOT >> /etc/sysconfig/iptables
# Zabbix-agent
-A RH-Firewall-1-INPUT -p tcp –dport 10050 -j ACCEPT
EOT

/sbin/service iptables save
service iptables restart

echo "Configuration zabbix-agent..."
sed -i "s/^Server=127.0.0.1$/Server=10.40.0.60/" /etc/zabbix/zabbix_agentd.conf && echo "Zabbix Server IP successfully changed"
sed -i "s/^ServerActive=127.0.0.1$/ServerActive=10.40.0.60/" /etc/zabbix/zabbix_agentd.conf && echo "Zabbix ServerActive IP successfully changed"

service zabbix-agent restart
