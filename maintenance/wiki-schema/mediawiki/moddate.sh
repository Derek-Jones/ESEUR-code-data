#
# moddate.sh, 20 Mar 11

cat wikihis* | awk -f moddate.awk | sort -g -k5 

