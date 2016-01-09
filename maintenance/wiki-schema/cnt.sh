#
# cnt.sh,  4 Oct 13

TEMP="$$.t"

for f in mediawiki/tables/*.sql
   do
# echo "$f" > /dev/tty
   cat $f
# Handle files that don't have a terminating newline character
   echo ""
   echo "END_FILE  $f"
   done | awk -f cntsql.awk > $TEMP

sed '1,/versions/d' < $TEMP | awk -f mksurvive.awk > tabcol_life.csv


