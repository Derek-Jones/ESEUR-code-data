#
# getmethod.sh, 10 Mar 15

echo "method_seq,uses,num_methods,total_seqs"
awk -f getmethod.awk |   sort -gr --field-separator="," -k2

