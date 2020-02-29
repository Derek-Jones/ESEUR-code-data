#
# add_filestr.sh, 18 Jun 18

suffix=".d"

for f in *$suffix
   do
   raw_file=`basename $f $suffix`
   awk -f ./add_filestr.awk -v file_str="$raw_file" < "$f"
   done

# for f in *.csv
#    do
#    raw_file=`basename $f .csv`
#    awk -f /home/data-rbook/add_filestr.awk -v file_str="$raw_file" < "$f"
#    done

# 
