#!/bin/bash

cd Test
server=10.129.200.200
echo "Number of machine to conduct test"

read num

echo "Duration of Test in Seconds"
read dur

mkdir testof$num-$(date +%d%H%M)

cd testof$num-$(date +%d%H%M)

if	[ $num -eq 1 ]
then 
	echo "give ip of 1 machine"
	read ip1
	tshark -i eth0 -a duration:$dur host $ip1 -w testmachine-$(date +%d%m%H%M).pcap

elif	[ $num -eq 2 ]
then

	echo "give ip of 1 machine"
	read ip1
	echo "give ip of 2 machine"
	read ip2	
	tshark -i eth0 -a duration:$dur host $ip1 or host $ip2 -w testmachine-$(date +%d%m%H%M).pcap

	tshark -r testmachine-$(date +%d%m%H%M).pcap>testmachine-$(date +%d%m%H%M).csv
	sed -i '/TCP Dup/d' testmachine-$(date +%d%m%H%M).csv
	sed -i '/TCP Retransmission/d' testmachine-$(date +%d%m%H%M).csv

elif	[ $num -eq 3 ]
then
	echo "give ip of 1 machine"
	read ip1
	echo "give ip of 2 machine"
	read ip2
	echo "give ip of 3 machine"
	read ip3
	tshark -i eth0 -a duration:$dur host $ip1 or $ip2 or $ip3 -w testmachine-$(date +%d%m%H%M).pcap
	
elif	[ $num -eq 4 ] 
then

	echo "give ip of 1 machine"
	read ip1
	echo "give ip of 2 machine"
	read ip2
	echo "give ip of 3 machine"
	read ip3
	echo "give ip of 4 machine"
	tshark -i eth0 -a duration:$dur host $ip1 or $ip2 or $ip3 or $ip4 -w testmachine-$(date +%d%m%H%M).pcap
else 

	echo "You have given wrong value"
	exit 0
fi

filename=$(ls -Art | tail -n 1)
echo $filename
 

tshark -r $filename -T fields -e ip.src -e frame.len -E separator=, -E occurrence=f>CapFileTestSrc.csv

##### Packets Calculation #####

if	[ $num -eq 1 ]
then 	
	{
		awk 'END {print NR}' CapFileTestSrc.csv>TotalPacket.csv 
		echo " Total number of Packet Capture:" `cat TotalPacket.csv`

		sed -n "/$server/p" CapFileTestSrc.csv > CapServerPackets.csv
		awk 'END {print NR}' CapServerPackets.csv>TotalServer.csv
		echo " Total Server Packets on Client:" `cat TotalServer.csv`

		sed -n "/$ip1/p" CapFileTestSrc.csv > CapClientPackets.csv
		awk 'END {print NR}' CapClientPackets.csv>TotalClient.csv
		echo " Total Download Packet by Client:" `cat TotalClient.csv`
	}

elif	[ $num -eq 2 ]
then 
	{
		awk 'END {print NR}' CapFileTestSrc.csv>TotalPacket.csv 
		echo " Total number of Packet Capture:" `cat TotalPacket.csv`

		sed -n "/$server/p" CapFileTestSrc.csv > CapServerPackets.csv
		awk 'END {print NR}' CapServerPackets.csv>TotalServerPackets.csv
		echo " Total Server  Packet on Clients:" `cat TotalServerPackets.csv`

		sed -n "/$ip1/p" CapFileTestSrc.csv > CapPackets$ip1-.csv
		awk 'END {print NR}' CapPackets$ip1-.csv>$ip1-packets.csv
		echo " Total  Packet by $ip1:" `cat $ip1-packets.csv`

		sed -n "/$ip2/p" CapFileTestSrc.csv > CapPackets$ip2-.csv
		awk 'END {print NR}' CapPackets$ip2-.csv>$ip2-packets.csv
		echo " Total  Packet by $ip2:" `cat $ip2-packets.csv`
	}


elif	[ $num -eq 3 ]
then	
	{
	
		awk 'END {print NR}' CapFileTestSrc.csv>TotalPacket.csv 
		echo " Total number of Packet Capture:" `cat TotalPacket.csv`

		sed -n "/$server/p" CapFileTestSrc.csv > CapServerPackets.csv
		awk 'END {print NR}' CapServerPackets.csv>TotalServerPackets.csv
		echo " Total Server  Packet on Clients:" `cat TotalServerPackets.csv`

		sed -n "/$ip1/p" CapFileTestSrc.csv > CapPackets$ip1-.csv
		awk 'END {print NR}' CapPackets$ip1-.csv>$ip1-packets.csv
		echo " Total  Packet by $ip1:" `cat $ip1-packets.csv`

		sed -n "/$ip2/p" CapFileTestSrc.csv > CapPackets$ip2-.csv
		awk 'END {print NR}' CapPackets$ip2-.csv>$ip2-packets.csv
		echo " Total  Packet by $ip2:" `cat $ip2-packets.csv`
	
	
		sed -n "/$ip3/p" CapFileTestSrc.csv > CapPackets$ip3-.csv
		awk 'END {print NR}' CapPackets$ip3-.csv>$ip3-packets.csv
		echo " Total  Packet by $ip3:" `cat $ip3-packets.csv`
	
	}
fi	
