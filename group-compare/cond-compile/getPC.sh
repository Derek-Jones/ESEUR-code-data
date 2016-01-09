#
# getPC.sh, 28 Jun 15

awk -f getPC.awk < FreeBSD-PC.txt | sort -g > FreeBSD-PC.csv
awk -f getPC.awk < Linux-PC.txt | sort -g > Linux-PC.csv

