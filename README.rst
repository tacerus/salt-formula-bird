
============
BIRD Formula
============

The BIRD project aims to develop a fully functional dynamic IP routing daemon primarily targeted on (but not limited to) Linux, FreeBSD and other UNIX-like systems and distributed under the GNU General Public License. 

Sample Pillars
==============

.. code-block:: yaml

    bird:
      server:
        network:
          engine: baremetal
        protocols:
          my_ospf:
            type: ospf
            tick: 2
            rfc1583compat: True
            ecmp: True
            areas:
              0.0.0.0:
                interfaces:
                  p3p1:
                    type: ptp
                    paramX: xxx
                  p3p2:
                    type: ptp
                    paramX: xxx
                  tap0: {}
                  vhost0:
                    hello: 9
                    type: broadcast
                    paramX: xxx
 

More Information
================

* http://bird.network.cz/
* https://gitlab.labs.nic.cz/labs/bird/wikis/home
