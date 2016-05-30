Host Enumeration
================
Performs some common enumeration techniques against a specific ip range. A work in progress.

### Synopsis
`./host_enumeration [ip range]`

### Description
Running the `host_enumation` script will create several `.txt` files in the current directory:
* `hosts_all.txt` contains a newline separated list of all hosts that are up
* `hosts_web.txt` contains a newline separated list of all hosts running a web service on port 80
* `hosts_nbtscan.txt` contains the result of the NetBios scan
* `hosts_port_scan.txt` contains port scan and banner grabbing results

### Dependencies
The `host_enumeration.sh` script uses the following tools:
* [nmap](https://nmap.org/)
* [nbtscan](http://www.inetcat.org/software/nbtscan.html)
* grep
* cut
