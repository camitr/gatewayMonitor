gatewayMonitor
==============
Intial bash file to run monitoring script to capture the traffic on central gateway machine.

Client Configuration 
====================
At the client end change the gateway for the transmission of packet between application server and client.


for windows client

::
        
        route add <application server ip> mask 255.255.255.255 <gateway ip>
        

To verify the gateway change use

::
        
        tracert <application server ip>

