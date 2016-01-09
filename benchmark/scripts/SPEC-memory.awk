#
# SPEC-memory.awk, 7 Feb 14

# Extract memory information from SPEC.org csv file
#
# awk -f ... < cpu2006-results-20140206.csv

BEGIN {
	line_num=1
# DDR/PC convertion numbers taken from Wikipedia
# It is possible to calculate the mapped values, however these
# differ from the numbers that are actually used (for marketing
# reasons the least significant digits are rounded).

	DDR2[400]=3200
	DDR2[533]=4200
	DDR2[667]=5300
	DDR2[800]=6400
	DDR2[1066]=8500

	DDR3[800]=6400
	DDR3[1066]=8500
	DDR3[1333]=10600
	DDR3[1600]=12800
	DDR3[1866]=14900
	DDR3[2133]=17000
	print "mem_kind,mem_rate,mem_freq"
	}

# skip first line which lists column names
line_num == 1 {
	line_num++
	next
	}

# Scan along input fields looking for id strings we know about
# Extract following number
function find_rate()
{
for (f=3; f <= NF; f++)
   if (index($f, "DDR") != 0)
      {
      if (length($f) > 6)
         rate=substr($f, 6, 4)
      else
	 rate=$(f+1)
      return
      }
   else if ($f ~ /PC[23]/)
      {
      if (length($f) > 5)
	 if ($f ~ /PC[23]L/)
	    rate=substr($f, 6, 5)
	 else
	    rate=substr($f, 5, 5)
      else
	 rate=$(f+1)
      return
      }
}

# Normalise number that should be a frequency
function mem_freq(freq)
{
gsub("\\(", "", freq)
gsub("\\)", "", freq)
gsub(",.*$", "", freq)
if (freq == "")
   freq="NA"
if (1+freq-1 != freq)
   print "NA"
else
   print freq
}


	{
	rate="NA"
	mem_kind="NA"
	}

$0 ~ /DDR2/ {
	mem_kind="DDR2"
	find_rate()
	}

$0 ~ /DDR3/ {
	mem_kind="DDR3"
	find_rate()
	}

$0 ~ /PC2/ {
	mem_kind="PC2"
	find_rate()
	}

$0 ~ /PC3/ {
	if ($0 ~ /PC3L/)
	   mem_kind="PC3L"
	else
	   mem_kind="PC3"
	find_rate()
	}

	{
	gsub("\"", "", rate)
	gsub("\\(", "", rate)
	gsub("\\)", "", rate)
	gsub(",.*$", "", rate)
	if (mem_kind == "DDR2")
	   {
	   mem_kind="PC2"
	   rate=DDR2[rate]
	   }
	else if (mem_kind == "DDR3")
	   {
	   mem_kind="PC3"
	   rate=DDR3[rate]
	   }
	if (rate == "")
	   rate="NA"
	printf("%s,%s,", mem_kind, rate)
	}


$0 ~ / MHz/ {
	for (f=3; f <= NF; f++)
	   if (index($f, "MHz") != 0)
	      {
	      mem_freq($(f-1))
	      next
	      }
	next
	}


$0 ~ /[0-9]MHz/ {
	for (f=3; f <= NF; f++)
	   if (index($f, "MHz") != 0)
	      {
	      mem_freq(substr($f, 1, length($f)-3))
	      next
	      }
	next
	}

	{
	print "NA"
	}

