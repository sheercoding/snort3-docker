Create Snort3 dockedr image.


This is a simple Dockfile for using Snort3. 

Build image
===========
make snort3-builder

Run image
=========
make snort3-sh

Test user case
==============
1> create a '.env' in your local filesystem and indicate pcap_dir and pcap_filename by export
        export pcap_dir=/root/xxxx
        export pcap_filename=yyyy (without the '.pcap' suffix)

2> make snort3-pcap


Resources
==========
Snort3 Guide:   https://docs.snort.org/start/installation
snort rules:    http://www.snort.org/downloads
pcap data:      https://download.netresec.com/pcap/maccdc-2012/maccdc2012_00001.pcap.gz
