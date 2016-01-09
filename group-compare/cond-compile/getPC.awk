#
# getPC.awk, 29 Jun 15
#

# amd64/amd64/stack_machdep.c: (amd64 && (ddb || stack))
# arch/x86/crypto/aes-i586-asm_32.S: (CRYPTO_AES_586==y || CRYPTO_AES_586==m)
BEGIN {
	FS=":"
	for (i=0; i <= 20; i++)
	   pc_cnt[i]=0
	}

	{
	num_conditions++
	gsub("\\(", " ", $2)
	gsub("\\)", " ", $2)
	gsub("\\|", " ", $2)
	gsub("\\&", " ", $2)
	gsub("\\==y", " ", $2)
	gsub("\\==n", " ", $2)
	gsub("\\==m", " ", $2)
	gsub("\\=", " ", $2)
	num_pcs=split($2, pcs, " ")
# a PC of 1 is a special case
	if ((num_pcs == 1) && (pcs[1] == "1"))
	   {
	   pc_cnt[0]++
	   next
	   }
	for (p in pcs)
	   local_pc[pcs[p]]=1
	pc_cnt[length(local_pc)]++
	if (length(local_pc) == 0)
	   print $0
	for(p in local_pc)
	   pc_occur[p]++
	delete local_pc
	# print $2
	next
	}

END {
	print "features,count"	
	for (p in pc_cnt)
	   print p "," pc_cnt[p]
#	for (p in pc_occur)
#	   print p "," pc_occur[p]
	}

