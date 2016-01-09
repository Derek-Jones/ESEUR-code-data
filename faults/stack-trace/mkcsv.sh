#
# mkcsv.sh, 20 Apr 15
#


function stack_csv()
{
TEMP_FILE="t.$$"
bunzip2 < $1 > $TEMP_FILE
echo "time,offset,count"
./map $TEMP_FILE | \
awk  -e	'($1 == "ws") || ($1 == "#") { next }
	{ print $1 "," $2 "," $3 }'
rm $TEMP_FILE
}


for infile in *.bz2
   do stack_csv $infile > "$infile.csv"
   done


