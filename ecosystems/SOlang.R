#
# SOlang.R, 13 Aug 19
# Data from:
# Stack Overflow Trends. .
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG language_question question_tag evolution stack-overflow


source("ESEUR_config.r")


library("plyr")
library("xml2")


# Extract y-axis information
y_val_pos=function(max_percent)
{
y_axis=xml_children(chart)[4]
y_cont=xml_contents(y_axis)
y_2=attributes(as_list(y_cont[[2]]))

# This is just too fiddle to extract.  Cheat, and do it by eye/hand
# Zero y coordinate is at the top

return(data.frame(y_percent=max_percent, y_offset=300.5))
}


# Extract x-axis information
x_val_pos=function()
{
x_axis=xml_children(chart)[1]
x_cont=xml_contents(x_axis)
x_2=attributes(as_list(x_cont[[2]]))

# This is just too fiddle to extract.  Cheat, and do it by eye/hand
# Zero x coordinate is on the left

return(data.frame(start_year=2009, end_year=2019,
		start_x=15.741867369125274+0.5, end_x=391.38662401739424+0.5))
}


# Get svg path string and return x/y coordinates of line segments
path_2_xy=function(lang)
{
l1=attributes(as_list(lang)) # yes, but it gets the data into a usable form
pts=substring(gsub("L", ",", l1$d), 2)
pt_vals=as.numeric(unlist(strsplit(pts, ",")))

return(data.frame(x=pt_vals[seq(1, length(pt_vals), 2)],
                  y=pt_vals[seq(2, length(pt_vals), 2)],
		  lang=l1$"data-legend"))
}


# Get x/y coordinates, then convert them to year/percentage
lang_2_year_perc=function(lang, x_info, y_info)
{
xy=path_2_xy(lang)

xy$year=x_info$start_year+(xy$x-x_info$start_x)*
	(x_info$end_year-x_info$start_year)/(x_info$end_x-x_info$start_x)

xy$percent=(y_info$y_offset-xy$y)*y_info$y_percent/y_info$y_offset

return(xy)
}


# Read svg file and extract language percentages
extract_lang=function(svg_str, max_perc)
{
SO=read_xml(paste0(ESEUR_dir, "ecosystems/", svg_str), as.is=TRUE)

chart=xml_children(SO)[2]

x_info=x_val_pos()
y_info=y_val_pos(max_perc)

langs=xml_children(chart)[6]
langs=xml_contents(langs)

# A useful way of checking extracted values
# l1=lang_2_year_perc(langs[[1]], x_info, y_info)
#  
# plot(0, type="n",
# 	xlim=c(2008.5, 2019.5), ylim=c(0, max_perc),
# 	xlab="Year", ylab="Percent")
# 
# lines(l1$year, l1$percent)

all_lang=ldply(langs, lang_2_year_perc, x_info, y_info)

all_lang$x=NULL
all_lang$y=NULL

return(all_lang)
}


# l_total=ddply(all_lang, .(year), function(df) sum(df$percent))
# plot(l_total)

SO_1=extract_lang("SOlang1.svg", 16) # 16 found by looking at the image
SO_2=extract_lang("SOlang2.svg", 4)  # can also be found by looking at the file
SO_3=extract_lang("SOlang3.svg", 0.9)

# write.csv(SO_1, "SO_1.csv", row.names=FALSE)
# write.csv(SO_2, "SO_2.csv", row.names=FALSE)
# write.csv(SO_3, "SO_3.csv", row.names=FALSE)

# l_total=ddply(SO_1, .(year), function(df) sum(df$percent))
# plot(l_total)

# sl=read.csv(paste0(ESEUR_dir, "ecosystems/SO_lang_tag.csv.xz"), as.is=TRUE)
# l_total=ddply(sl, .(year), function(df) sum(df$percent))
# plot(l_total)


