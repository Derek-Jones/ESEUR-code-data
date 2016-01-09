#
# stack_use.R, 20 Apr 15
#
# Data from:
# Brigham Young University Trace Distribution Center:
# http://tds.cs.byu.edu/tds/.
# Above website nolonger available.
# Thanks to Dror G. Feitelson for supplying a copy.
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(20)
plot_layout(2, 1)

trace_image=function(file_str)
{

# time,offset,count
gzip=read.csv(paste0(ESEUR_dir, "faults/stack-trace/", file_str), as.is=TRUE)

start_offset=300

gzip=subset(gzip, (offset <= 520) & (offset > start_offset))

image_map=matrix(data=0, nrow=1+max(gzip$time), ncol=max(gzip$offset)-start_offset)

image_map[cbind(1+gzip$time, gzip$offset-start_offset)]=gzip$count

image(z=log(image_map), col=pal_col, axes=FALSE,
	xlab="Time", ylab="Address\n")
x_labs=seq(0, max(gzip$time), by = 20)
y_labs=seq(0, 520-start_offset, by = 50)
axis(1, at=x_labs/max(x_labs), labels = x_labs)
axis(2, at=y_labs/max(y_labs), labels = y_labs)
}


# trace_image("gzip_graphic.tr.bz2.csv.xz")
trace_image("gzip_log.tr.bz2.csv.xz")
# trace_image("gzip_program.tr.bz2.csv.xz")
# trace_image("gzip_random.tr.bz2.csv.xz")
trace_image("gzip_source.tr.bz2.csv.xz")

