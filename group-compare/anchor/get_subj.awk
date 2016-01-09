#
# get_subj.awk,  2 Apr 15
#

# A1,Professional,No anchor,Q1.4,NA,

BEGIN {
	FS=","
	}

$2 == "Professional" {
	if ($4 == "Q1.2")
	   years=$5
	if ($4 == "Q1.3")
	   proj_lead=$5
	if ($4 == "Q1.4")
	   subj[$1]="P," $3 "," years "," proj_lead ",NA,NA,NA,NA"
	}

$2 == "Student" {
	if ($4 == "Q1.1")
	   num_courses=$5
	if ($4 == "Q1.2")
	   LOC=$5
	if ($4 == "Q1.3")
	   self_opin=$5
	if ($4 == "Q1.4")
	   subj[$1]="S," $3 ",NA,NA," num_courses "," LOC "," self_opin "," $5
	}

	{
	if ($4 == "START")
	   subj[$1]=subj[$1] "," $6
	if ($4 == "TECH")
	   subj[$1]=subj[$1] "," $5
	if ($4 == "NACT")
	   subj[$1]=subj[$1] "," $5
	if ($4 == "MIN")
	   subj[$1]=subj[$1] "," $5
	if ($4 == "ML")
	   subj[$1]=subj[$1] "," $5
	if ($4 == "MAX")
	   subj[$1]=subj[$1] "," $5
	if ($4 == "UNC1")
	   subj[$1]=subj[$1] "," $5
	if ($4 == "UNC2")
	   subj[$1]=subj[$1] "," $5
	if ($4 == "UNC3")
	   subj[$1]=subj[$1] "," $5
	if ($4 == "STOP")
	   subj[$1]=subj[$1] "," $6
	next
	}


END {
	print "ID,PS,CATEGORY,YEARS,PROJ_LEAD,num_course,LOC,self_opin,prof_exp,START,TECH,NACT,MIN,ML,MAX,UNC1,UNC2,UNC3,STOP"

	for (p in subj)
	   print p "," subj[p]
	}

