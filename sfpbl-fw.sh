#!/bin/bash
#
#
#
iptables -F INPUT
#
#   PUT YOUR PERSONAL RULES HERE
#
#
#   REDIRECT 9877 9875 AND 80 TO spfblaccept
#
iptables -t filter -A INPUT -p tcp -m multiport --dports 9877,9875,80 -j spfblaccept 
#
#   
#
if [ -e sfpbl-fw-accept.sh ]
then
    ./sfpbl-fw-accept.sh
fi
#
#   REDIRECT 53 TO spfbldns
#
iptables -t filter -A INPUT -p tcp --dport 53 -j spfbldns
#
#
#
if [ -e sfpbl-fw-drop.sh ]
then
    ./sfpbl-fw-drop.sh
fi
