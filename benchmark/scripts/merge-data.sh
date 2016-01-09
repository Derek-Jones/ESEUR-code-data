#
# merge-data.sh, 28 Jan 14

echo "disk,sd_id,trial,total_sectors,offset,time,bandwidth"

for f in *.data
   do
   awk -f ../../scripts/merge-data.awk -v file_name="$f" < "$f"
   done

