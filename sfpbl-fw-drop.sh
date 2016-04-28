#!/bin/bash
#
#
#   
_chain="spfbldns"
_interface="eth0"
_list="input-drop"
#
#
#
_chainkey="$(iptables -L -n | grep "$_chain")"
if [ -z "$_chainkey" ]
then
    iptables -N "$_chain"
else
    iptables -F "$_chain"
fi
#
#
#
for i in $(grep -v "^#" "$_list")
do
    _src="$(echo "$i" | cut -d';' -f1)"
    _port="$(echo "$i" | cut -d';' -f2)"
    _prot="$(echo "$i" | cut -d';' -f3)"
    _com="$(echo "$i" | cut -d';' -f4)"
    iptables -A "$_chain" -s "$_src" -p "$_prot" --dport "$_port" -j LOG --log-prefix "$_chain DROP"
    iptables -A "$_chain" -s "$_src" -p "$_prot" --dport "$_port" -m comment --comment "$_com" -j DROP
done
#
#
#
iptables -A "$_chain" -j REJECT

