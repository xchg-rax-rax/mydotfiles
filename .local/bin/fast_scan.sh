#!/bin/bash
ip=$1
echo "[*] Scanning $ip";

echo "[*] Starting 2 stage TCP port scan";
tcp_ports=$(sudo nmap -T5 $ip -p- -Pn | grep "open  " | cut -d '/' -f 1 | paste -sd, -);
echo "[*] The following open ports were found $tcp_ports";
sudo nmap -T4 $ip -p- -vvv -Pn --script='vuln' -A -oN $ip.tcp.scan 1>/dev/null 2>/dev/null || ( echo "[!] TCP scan failed."; exit 1);
echo "[+] TCP scan complete! Results follow...";
cat $ip.tcp.scan

echo "[*] Starting UDP scan"
udp_ports=$(sudo nmap -sUV -T4 $ip -Pn -oN $ip.udp.scan | grep "open  " | cut -d '/' -f 1 | paste -sd, -);
echo "[+] UDP scan complete! Results follow...";
cat $ip.udp.scan
