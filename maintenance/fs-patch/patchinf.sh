#
# patchinf.sh,  9 Jun 13

for f in *-patch
   do
   awk -f patchinf.awk < $f > "c-$f"
   done

cat c-* > p-all.csv

