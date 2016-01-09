#
# dev-hist.sh, 27 Oct 14
#
# Extract dates from commit logs found at github.com/gregkh/kernel-history
# Output used by dc-simex.R

echo "author,count,first date,release"

for f in log*
   do
   awk -f dev-hist.awk -vlinux_rel="$f" < $f
   done

