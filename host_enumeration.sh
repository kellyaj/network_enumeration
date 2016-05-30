#!/bin/bash

hostRange=$1

allHosts=`/usr/bin/nmap -sn $hostRange | grep "report for"`
echo "$allHosts" | cut -d " " -f 5 > hosts_all.txt
printf "\nfound `echo "$allHosts" | wc -l` hosts in total, see hosts_all.txt\n"

webHosts=`/usr/bin/nmap -p 80 $hostRange | grep "report for"`
echo "$webHosts" | cut -d " " -f 5 > hosts_web.txt
printf "\nfound `echo "$webHosts" | wc -l` hosts with port 80 open, see hosts_web.txt\n"

printf "\nusing nbtscan to get NetBIOS information, see hosts_nbtscan.txt\n"
/usr/bin/nbtscan -r -f ./hosts_all.txt > hosts_nbtscan.txt

printf "\nrunning numerous scans against all known hosts, this may take a while. see hosts_port_scan.txt\n"

ipList=`cat ./hosts_all.txt`
for ip in $ipList; do
  printf "\nscanning open ports on ${ip}\n"
  defaultScan=`/usr/bin/nmap -sV -sS $ip`
  echo "$defaultScan" >> hosts_port_scan.txt
  if [[ $defaultScan =~ "139/tcp" || $defaultScan =~ "445/tcp" ]]
  then
    printf "detected ${ip} has SMB ports (139, 445) open\n"
    printf "running smb-os-discovery.nse against ${ip}\n"
    /usr/bin/nmap $ip --script smb-os-discovery.nse >> hosts_smb_os_discovery.txt
  fi
done
