function cpureport {
	#CPU Info Section Function base
	cpumodel=$(grep -m1 'Model name:' /tmp/cpuinfo2.$$ | sed 's/.*Model name: *//')
	cpumanufacturer=$(grep -m1 vendor: /tmp/cpuinfo.$$ | sed 's/.*vendor: *//')
	cpuarchitecture=$(grep -m1 Architecture: /tmp/cpuinfo2.$$ | sed 's/.*Architecture: *//')
	cpucorecount=$(grep -m1 'CPU(s):' /tmp/cpuinfo2.$$ | sed 's/.*CPU(s): *//')
	cpumaxspeed=$(grep -m1 capacity: /tmp/cpuinfo.$$ | sed 's/.*capacity: *//')
	cpucachesize=$(grep cache /tmp/cpuinfo2.$$)
	
cat << EOF

~~~~~~~~~~SYSTEM CPU INFORMATION~~~~~~~~~~

CPU Vendor: $cpumanufacturer

CPU Info: $cpumodel

Architechture: $cpuarchitecture

Available CPU Cores: $cpucorecount 

Max CPU Clock Rate: $cpumaxspeed

CPU Cache Sizes:
$cpucachesize

EOF
}

function computerreport {
	#Computer Report Function base
	computermodel=$(sudo dmidecode -s system-product-name)

	computermanufacturer=$(dmidecode -s system-manufacturer)
	#Checking this line if the Machine is Virtualized.
	
	computerserial=$(grep -m1 serial: /tmp/sysinfo.$$ | sed 's/ *serial: *//')
cat <<EOF
~~~~~~~~~~COMPUTER INFORMATION~~~~~~~~~~
$(if [ "$(grep -m1 product: /tmp/sysinfo.$$| sed 's/ *product: *//')" = "VMware Virtual Platform" ]; 	then
		echo "**This is a Virtual Machine**"
	fi)
	
Manufacturer: $computermanufacturer

Computer Model: $computermodel

Computer Serial: $computerserial

EOF
}

function osreport {
	#OS Report Section base
	source /etc/os-release
cat << EOF

~~~~~~~~~~OPERATING SYSTEM~~~~~~~~~~

Linux Distro: $NAME
Distro Version: $VERSION

EOF
}

function ramreport {
	#RAM Report Function base
	rammanu=
	ramcompsize=
	ramspeed=$(dmidecode -t memory | grep -i -m1 'Current Speed' | sed 's/.*Current Speed: *//')
	ramphysloc=
	ramtotalsize=
cat << EOF
	
~~~~~~~~~~SYSTEM MEMORY INFORMATION~~~~~~~~~~

Memory Manufacturer:

Memory Model:

Memory Component Size:

Memory Current Speed: $ramspeed

Memory Physical Location:

TOTAL System Memory:

EOF
}

function videoreport {
	#Video Report Function Base
	vidmanu=$(grep -m1 vendor: /tmp/vidinfo.$$ | sed 's/.*vendor: *//')
	vidmodel=$(grep -m1 description: /tmp/vidinfo.$$ | sed 's/.*description: *//')
cat << EOF
	
~~~~~~~~~~VIDEO DEVICE INFORMATION~~~~~~~~~~

Video Device Manufacturer: $vidmanu

Video Device Model: $vidmodel

EOF
}

#function diskreport {
#
#}
#
function networkreport {
#Network Report Function Base
netmanu=$(grep -m1 vendor: /tmp/netinfo.$$ | sed 's/.*vendor: *//')
netmodel=$(grep -m1 product: /tmp/netinfo.$$ | sed 's/.*product: *//')
netlink=$(grep -m1 link /tmp/netinfo.$$ | sed 's/.*link=\([^[:space:]]*\).*/\1/')
netspeednow=$(grep -m1 size: /tmp/netinfo.$$ | sed 's/.*size: *//')
netipadd=$(grep -m1 'full ip=' /tmp/netinfo.$$ | sed 's/.*full ip=\([^[:space:]]*\).*/\1/')
#netbridge=$(grep -m1 : /tmp/netinfo.$$ | sed 's/.*: *//')
netdns=$(grep -E '^nameserver' /etc/resolv.conf | awk '{print $2}')
cat << EOF
Network Device Manufacturer: $netmanu

Network Device Model: $netmodel

Network Link Active: $netlink

Network Current Speed: $netspeednow

Network Connected IP Address: $netipadd

Registered DNS Nameservers: $netdns

EOF
}
#
#function errormessage {
#
#}
