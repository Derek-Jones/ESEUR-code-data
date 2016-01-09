#
# java-type.awk, 30 Sep 15
#

BEGIN {
	print "short_offset,full_offset,answer"
	short_offset="NA,"
	}

# USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 1,
# Answer.UPGRADE_SUCCEEDS,

$3 == "SHORT_SURVEY_OFFSET" {
	short_offset=$5
	next
	}

$3 == "FULL_SURVEY_OFFSET" {
	full_offset=$5
	getline
	gsub(",", "", $1)
	answer=substr($1, 8)
	print short_offset full_offset answer
	short_offset="NA,"
	next
	}

