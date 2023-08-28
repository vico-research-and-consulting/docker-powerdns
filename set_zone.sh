#!/bin/bash
set -e
DATE=`date +%Y%m%d`01
pdnsutil replace-rrset $1 '' SOA "$2 $3 $DATE 10800 3600 604800 3600"
pdnsutil replace-rrset $1 '' NS "$2"
