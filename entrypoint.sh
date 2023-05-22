#!/bin/sh

# exec snort -V 
exec snort -c /etc/snort/etc/snort.lua "$@"
