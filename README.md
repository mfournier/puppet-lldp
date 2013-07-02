Puppet LLDP module
==================

Install, and run `lldpd` on RHEL & Debian -based systems.

This will allow your servers to chat with the switches they are connected to
and exchange various configuration metadata.

This module also parses the output of `lldpctl` and provides a couple of facts
out of the data returned. Example:

```shell
# facter | grep lldp
lldp_chassis_name => hn6.infra.example.com,switch4
lldp_eth0_chassis_name => hn6.infra.example.com
lldp_eth0_port_descr => eth0
lldp_eth1_chassis_name => switch4
lldp_eth1_port_descr => ge-0/0/1.0
lldp_eth1_vlan => FOO,BAR
lldp_eth1_vlan_vlan_id => 192,66
lldp_port_descr => eth0,ge-0/0/1.0
lldp_vlan => FOO,BAR
lldp_vlan_vlan_id => 192,66
```

Licence
-------

Apache, see http://www.apache.org/licenses/LICENSE-2.0

Contributors
------------

 * Allan
 * Marc Fournier
 * Jonas Genannt
 * Francois Deppierraz
 * David Schmitt
