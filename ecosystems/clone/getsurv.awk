#
# getsurv.awk, 24 Nov 13

BEGIN {
	fragnum=0
	print "frag_num,clone_class,clone_type,clone_start,clone_end,start_ver,end_ver,file"
	}

function print_line()
{
print frag_num "," cloneclass "," clonetype "," clone_start "," clone_end "," start_ver "," end_ver "," file
}

# /home/nils/uni/test/Test/scsi_1.0  CloneClass 2 (Type 3)
$2 == "CloneClass" {
	cloneclass=$3
	clonetype=substr($5, 1, 1)
	next
	}

# Fragment        3       113 :   118     scsi/scsi_debug.c
NF == 6 {
	frag_num=$2
	clone_start=$3
	clone_end=$5
	file=$6
	next
	}

#         Starts at:      1.0;             Ends at:       1.0     Life Span:      0 month
$1 == "Starts" {
	sub(";", "", $3)
	start_ver=$3
	end_ver=$6
	print_line()
	next
	}

