#
# xref.awk, 25 Mar 09

function get_doc_name(str)
{
start_off=index(str, "[MS")
end_off=index(str, "]")
return substr(str, start_off+1, end_off-start_off-1)
}

BEGIN {
	cur_file=""
	seen_xref["q"]=""
	misc_doc["MS-DOCO"]=1
	misc_doc["MS-DTYP"]=1
	misc_doc["MS-ERREF"]=1
	misc_doc["MS-FSCC"]=1
	misc_doc["MS-GLOS"]=1
	misc_doc["MS-LCID"]=1
	misc_doc["MS-REF"]=1
	misc_doc["MS-SECO"]=1
	misc_doc["MS-SYS"]=1
	misc_doc["MS-UCODEREF"]=1
	misc_doc["ReadmefirstWSPP"]=1
        popular_doc["MS-ADA1"]=1
        popular_doc["MS-ADA2"]=1
        popular_doc["MS-ADA3"]=1
        popular_doc["MS-ADSC"]=1
        popular_doc["MS-ADTS"]=1
        popular_doc["MS-DCOM"]=1
        popular_doc["MS-DRSR"]=1
	popular_doc["MS-GPOL"]=1
        popular_doc["MS-KILE"]=1
	popular_doc["MS-LSAD"]=1
        popular_doc["MS-NLMP"]=1
        popular_doc["MS-NRPC"]=1
	popular_doc["MS-PAC"]=1
        popular_doc["MS-RPCE"]=1
	popular_doc["MS-SAMR"]=1
        popular_doc["MS-SMB"]=1
        popular_doc["MS-SMB2"]=1
        popular_doc["MS-SPNG"]=1

	}

$1 ~ /^C:/ {
	if (cur_file != "")
	   all_xrefs[cur_file]=cnt_xref " " all_xrefs[cur_file]
	num_files=split($1, file_list, "\\")
	cur_file=get_doc_name(file_list[num_files])
#print $1
#print cur_file
	all_xrefs[cur_file]=""
	delete seen_xref
	seen_xref[cur_file]=1
	cnt_xref=0
	next
	}

	{
	for (w=2; w < NF; w++)
	   {
# Citatations to MS documents in the References
# section appear to be followed by the words "Microsoft Corporation"
	   if ($(w+1) != "Microsoft")
	      next
	   if ($w ~ /\[MS-/)
	      {
	      str=get_doc_name($w)
	      if ((keep_pop != 1) && (popular_doc[str] == 1))
		 next
              if ((seen_xref[str] == 0) && (misc_doc[str] == 0))
		 {
		 all_xrefs[cur_file]=all_xrefs[cur_file] " " str
		 seen_xref[str]=1
		 xref_refed[str]++
		 cnt_xref++
		 }
	      }
	   }
	next
	}

END {
# Information used to find out what documents are very popular
#	for (reqs in all_xrefs)
#	   if (misc_doc[reqs] != 1)
#	      printf("%-15s %3d %s\n", reqs, xref_refed[reqs], all_xrefs[reqs])
	print "digraph G {"
	print "size=\"7.0,8\";"
	print "ratio=fill;"
	for (reqs in all_xrefs)
	   if (misc_doc[reqs] != 1)
	      {
	      num_docs=split(all_xrefs[reqs], xref_docs)
	      for (d=2; d <= num_docs; d++)
	         printf("\"%s\" -> \"%s\";\n",  reqs, xref_docs[d])
	      }
	print "}"
	}

