#!/bin/bash

cd Tests
server=10.129.200.200

 iptxt='1.txt'
 i=0
 hosts='host '
 ors='or '


#function ips(){

#echo ${ip[1]}



	for each in `cat 1.txt`; do
		ips[i]=$hosts
		ips[i+1]=$each
		ips[i+2]=$ors
		i=$(($i+3))
	done
				
	wordcount=$(echo ${ips[@]} | wc -c)
						
	wordcountless2=$(($wordcount-3))
					
	para=$(echo ${ips[@]} | cut -c -$wordcountless2)
	echo $para
	#return 
#}

echo "Duration of Test in Seconds"
read dur

#mkdir testof-$(date +%d%H%M)

#cd testof-$(date +%d%H%M)

tshark -i eth0 -a duration:$dur $para -w PacketCap.pcap

i=0
	for each in `cat 1.txt`; do
		ip[i]=$each
		tshark -Y "ip.src == ${ip[i]} && ip.dst == $server" -r PacketCap.pcap >ip$i-.csv
		sed -i '/TCP Dup/d' ip$i-.csv
		sed -i '/TCP Retransmission/d' ip$i-.csv

		i=$(expr $i + 1)
		
	done
#echo ${ip[1]}
#
#
#
 
#if	[ $num -eq 1 ]
#then 	
#	{
#		awk 'END {print NR}' CapFileTestSrc.csv>TotalPacket.csv 
#		echo " Total number of Packet Capture:" `cat TotalPacket.csv`
#
#		sed -n "/$server/p" CapFileTestSrc.csv > CapServerPackets.csv
#		awk 'END {print NR}' CapServerPackets.csv>TotalServer.csv
#		echo " Total Server Packets on Client:" `cat TotalServer.csv`
#
#		sed -n "/$ip1/p" CapFileTestSrc.csv > CapClientPackets.csv
#		awk 'END {print NR}' CapClientPackets.csv>TotalClient.csv
#		echo " Total Download Packet by Client:" `cat TotalClient.csv`
#	}
#
#elif	[ $num -eq 2 ]
#then 
#	{
#		awk 'END {print NR}' CapFileTestSrc.csv>TotalPacket.csv 
#		echo " Total number of Packet Capture:" `cat TotalPacket.csv`
#
#		sed -n "/$server/p" CapFileTestSrc.csv > CapServerPackets.csv
#		awk 'END {print NR}' CapServerPackets.csv>TotalServerPackets.csv
#		echo " Total Server  Packet on Clients:" `cat TotalServerPackets.csv`
#
#		sed -n "/$ip1/p" CapFileTestSrc.csv > CapPackets$ip1-.csv
#		awk 'END {print NR}' CapPackets$ip1-.csv>$ip1-packets.csv
#		echo " Total  Packet by $ip1:" `cat $ip1-packets.csv`
#
#		sed -n "/$ip2/p" CapFileTestSrc.csv > CapPackets$ip2-.csv
#		awk 'END {print NR}' CapPackets$ip2-.csv>$ip2-packets.csv
#		echo " Total  Packet by $ip2:" `cat $ip2-packets.csv`
#	}
#
#
#elif	[ $num -eq 3 ]
#then	
#	{
#	
#		awk 'END {print NR}' CapFileTestSrc.csv>TotalPacket.csv 
#		echo " Total number of Packet Capture:" `cat TotalPacket.csv`
#
#		sed -n "/$server/p" CapFileTestSrc.csv > CapServerPackets.csv
#		awk 'END {print NR}' CapServerPackets.csv>TotalServerPackets.csv
#		echo " Total Server  Packet on Clients:" `cat TotalServerPackets.csv`
#
#		sed -n "/$ip1/p" CapFileTestSrc.csv > CapPackets$ip1-.csv
#		awk 'END {print NR}' CapPackets$ip1-.csv>$ip1-packets.csv
#		echo " Total  Packet by $ip1:" `cat $ip1-packets.csv`
#
#		sed -n "/$ip2/p" CapFileTestSrc.csv > CapPackets$ip2-.csv
#		awk 'END {print NR}' CapPackets$ip2-.csv>$ip2-packets.csv
#		echo " Total  Packet by $ip2:" `cat $ip2-packets.csv`
#	
#	
#		sed -n "/$ip3/p" CapFileTestSrc.csv > CapPackets$ip3-.csv
#		awk 'END {print NR}' CapPackets$ip3-.csv>$ip3-packets.csv
#		echo " Total  Packet by $ip3:" `cat $ip3-packets.csv`
#	
#	}
#fi	
