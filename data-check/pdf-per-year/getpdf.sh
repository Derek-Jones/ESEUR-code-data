#
# getpdf.sh, 28 Apr 14

sed -e '/pdf/!d' < web-file-fmt.tsv | sed -e '/version/!d' | \
   awk -e 'BEGIN {FS="\t" } \
	   { \
	   for (i=1; i <= NF; i++) \
		{ \
		off=index($i, "version="); \
		if (off > 0) \
			{ \
			ver_str=substr($i, off+8, 3); \
			ver_total[$(i+1) " " ver_str]+=$NF; \
			next \
			} \
		} \
	    next \
	    } \
	    END { for (v in ver_total) print v " " ver_total[v] } '

