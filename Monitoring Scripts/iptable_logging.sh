#!/bin/bash

# Logging
log()
{
    SOURCE=a.b.c.d (IP address)
    $IPT -A INPUT   -s $SOURCE -m limit --limit 50/minute -j LOG --log-level 7 --log-prefix "In: "
    $IPT -A OUTPUT  -s $SOURCE -m limit --limit 50/minute -j LOG --log-level 7 --log-prefix "Out: "
    $IPT -A FORWARD -s $SOURCE -m limit --limit 50/minute -j LOG --log-level 7 --log-prefix "Fw: "
    $IPT -t nat -A POSTROUTING -m limit --limit 50/minute -j LOG --log-level 7 --log-prefix "Nat: "
}
#log  (remove comment to enable)

trace()
{
    iptables -t raw -A PREROUTING -p tcp  -j TRACE
    iptables -t raw -A OUTPUT     -p tcp  -j TRACE
}
#trace (remove comment to enable)