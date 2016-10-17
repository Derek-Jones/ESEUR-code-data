#
# mkfieldclust.sh,  8 Oct 16

echo -n "Subject," > fieldclust.csv

cat item.list >> fieldclust.csv

cat 2008/scan* | awk -f absfield.awk   | awk -f mkfieldclust.awk -v fieldclust=6 >> fieldclust.csv

