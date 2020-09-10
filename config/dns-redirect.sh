#!/system/bin/sh

IP6TABLES=/system/bin/ip6tables
IPTABLES=/system/bin/iptables 

# Disable ipv6
# for FILE in `ls  /proc/sys/net/ipv6/conf/*/disable_ipv6`;do echo 1>$FILE;done;

# $IPTABLES -F
# $IPTABLES -t nat -F
# $IPTABLES -t nat -X

# Force a specific DNS
# First two lines delete current DNS settings 
$IPTABLES -t nat -D OUTPUT -p tcp ! -d 1.1.1.1 --dport 53 -j DNAT --to-destination 127.0.0.1:5354
$IPTABLES -t nat -D OUTPUT -p udp ! -d 1.1.1.1 --dport 53 -j DNAT --to-destination 127.0.0.1:5354

# These two new lines sets DNS running at 127.0.0.1 on port 5354 
$IPTABLES -t nat -A OUTPUT -p tcp ! -d 1.1.1.1 --dport 53 -j DNAT --to-destination 127.0.0.1:5354
$IPTABLES -t nat -A OUTPUT -p udp ! -d 1.1.1.1 --dport 53 -j DNAT --to-destination 127.0.0.1:5354

# For IPv6 we need to change it in a different way since there is no nat! 
# $IP6TABLES -A INPUT -i $LAN_IF -s $LAN_NET -p udp –dport 53 -j ACCEPT 
# $IP6TABLES -A FORWARD -i $LAN_IF -s $LAN_NET -p udp –dport 53 -j ACCEPT 
# $IP6TABLES -A OUTPUT -p udp –dport 53 -j ACCEPT

# restart dnscrypt-proxy

# /system/bin/pkill dnscrypt-proxy
