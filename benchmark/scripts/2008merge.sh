#
# 2008merge.sh, 28 Jan 14

echo "disk,sd_id,trial,offset,bandwidth"

for f in *.data
   do
   awk -f ../../scripts/2008merge.awk -v file_name="$f" < "$f"
   done

