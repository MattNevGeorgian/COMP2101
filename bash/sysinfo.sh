#!/bin/bash
# Lab 4 sysinfo

#checking for root privlege
if [ "$(id -u)" != "0" ]; then
	echo "Root is not active, and is required to work properly."
	echo "Please restart this script as root"
	exit 1
fi

#Gathering of items, referer to lab for more detail.
mydate=$(date)

#Temp File to optimize runtime. (Could be optimized further slightly)
lshw -class system >/tmp/sysinfo.$$ 2>/dev/null
lshw -class cpu >/tmp/cpuinfo.$$ 2>/dev/null
lscpu >/tmp/cpuinfo2.$$ 2>/dev/null

#Computer Report Function base
computermodel=$(sudo dmidecode -s system-product-name)

computermanufacturer=$(dmidecode -s system-manufacturer)
#Checking this line if the Machine is Virtualized.
if [ "$(grep -m1 product: /tmp/sysinfo.$$| sed 's/ *product: *//')" = "VMware Virtual Platform" ]; then
	echo "This is a Virtual Machine"
fi
computerserial=$(grep -m1 serial: /tmp/sysinfo.$$ | sed 's/ *serial: *//')



#CPU Info Section Function base
cpumodel=$(grep -m1 'Model name:' /tmp/cpuinfo2.$$ | sed 's/.*Model name: *//')
cpumanufacturer=$(grep -m1 vendor: /tmp/cpuinfo.$$ | sed 's/.*vendor: *//')
cpuarchitecture=$(grep -m1 Architecture: /tmp/cpuinfo2.$$ | sed 's/.*Architecture: *//')
cpucorecount=$(grep -m1 'CPU(s):' /tmp/cpuinfo2.$$ | sed 's/.*CPU(s): *//')
cpumaxspeed=$(grep -m1 capacity: /tmp/cpuinfo.$$ | sed 's/.*capacity: *//')
cpucachesize=$(grep cache /tmp/cpuinfo2.$$)

#OS Info Section
source /etc/os-release
#Using existing Variables

#sed needs to be researched.
#creates variable using lshw -class, (from -short) cass system, and searches for
#description,
#sed "s is subsitite"   /start/changeto/end
cat <<EOF
System Report generated by $USER on $mydate

System Description
------------------------

CPUREPORT

CPU Vendor: $cpumanufacturer

CPU Info: $cpumodel

Architechture: $cpuarchitecture

Available CPU Cores: $cpucorecount 

Max CPU Clock Rate: $cpumaxspeed

CPU Cache Sizes:
$cpucachesize


COMPUTERREPORT

Manufacturer: $computermanufacturer

Computer Model: $computermodel

Computer Serial: $computerserial




EOF
