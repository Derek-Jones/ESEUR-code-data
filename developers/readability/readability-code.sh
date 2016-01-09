#
# readability-code.sh,  2 Oct 11

function file_with_sep()
{
for f in `ls snippets/*.jsnp`
   do
   cat $f
   echo "X-X-X $f"
   done
}

file_with_sep | awk -f readability-code.awk

