gatewayMonitor
==============
Intial bash file to run monitoring script to capture the traffic on central gateway machine.

Client Configuration 
====================
At the client end change the gateway for the transmission of packet between application server and client.


windows client

::
        
        route add <application server ip> mask 255.255.255.255 <gateway ip>
        

To verify the gateway change use

::

        tracert <application server ip>


linux client

::

        sudo route add -host <application server ip> gw <gateway ip> netmask 0.0.0.0
        
        tracepath  <application server ip>


linux application server 

::
        
        ip route add <client ip> via <gateway ip> dev eth0



        
Gateway Server Configuration 
============================
Gateway server is the central machine which will route  traffic to and fro between  client and  application server.
The interface of the server should be in the forwarding mode.

To check Forwarding mode

::
        
        sudo sysctl net.ipv4.ip_forward

If output mode is 1 its interface is in forwarding mode

Enable forwarding mode 

::
        
        
        sudo sysctl net.ipv4.ipforward=1

Running the script 

Clone the repository 

::
        
        git clone https://github.com/camitr/gatewayMonitor.git

Create a directory and file

::
        
        mkdir Tests
        touch 1.txt
       
Run the script

::
        
        bash Cmonitor.sh

Argument to provide

::
        
        Type the IP 
        Duration of test in seconds
        
