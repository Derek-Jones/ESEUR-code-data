#
# labov73.R,  7 Dec 19
# Data from:
# The boundaries of words and their meaning
# William Labov
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human word_meaning


source("ESEUR_config.r")


plot_layout(2, 1)


left_arc=function(x, y, d_x, d_y)
{
lines(spline(c(x, x-d_x*0.6, x-d_x),
	     c(y, y+d_y*0.5, y+d_y)), col=col_str)
}

right_arc=function(x, y, d_x, d_y)
{
lines(spline(c(x, x+d_x*0.6, x+d_x),
	     c(y, y+d_y*0.5, y+d_y)), col=col_str)
}

down_smile=function(x1, y, x2)
{
lines(spline(c(x1, (x1+x2)/2, x2),
	     c(y, y-0.1, y)), col=col_str)
}

up_smile=function(x1, y, x2)
{
lines(spline(c(x1, (x1+x2)/2, x2),
	     c(y, y+0.1, y)), col=col_str)
}

handle=function(width, height, x_base, y_base)
{
x_hb=x_base+width
y_hb=y_base+height

lines(spline(c(x_hb+0.2, x_hb+0.3, x_hb+0.6, x_hb+0.7),
	     c(y_hb-0.1*height, y_hb-0.11*height, y_hb-0.15*height, y_hb-0.3*height)),
		col=col_str)
lines(spline(c(x_hb+0.11, x_hb+0.3, x_hb+0.64, x_hb+0.7),
	     c(y_hb-0.62*height, y_hb-0.53*height, y_hb-0.40*height, y_hb-0.3*height)),
		col=col_str)
points(x_hb+0.4, y_hb-0.3*height, pch=21, cex=1.0, col=col_str)
}


cup_bowl=function(width, height, x_base, y_base)
{
left_arc(x_base, y_base, 0.2, height)
down_smile(x_base, y_base, x_base+width)
right_arc(x_base+width, y_base, 0.2, height)
down_smile(x_base-0.2, y_base+height, x_base+width+0.2)
up_smile(x_base-0.2, y_base+height, x_base+width+0.2)

handle(width, height, x_base, y_base)
}


plot(0, type="n", bty="n",
	xaxt="n", yaxt="n", xaxs="i", yaxs="i",
	xlim=c(0.8, 13), ylim=c(-0.08, 12.6),
	xlab="", ylab="")

colfunc=colorRampPalette(c("black", pal_col[1]))
col_range=colfunc(5)
col_str=col_range[5]
cup_bowl(width=1.0, height=2.5, x_base=11.0, y_base=10.0)
col_str=col_range[4]
cup_bowl(width=1.0, height=1.9, x_base=8.5, y_base=10.0)
col_str=col_range[3]
cup_bowl(width=1.0, height=1.5, x_base=6.0, y_base=10.0)
col_str=col_range[2]
cup_bowl(width=1.0, height=1.2, x_base=3.5, y_base=10.0)
col_str=col_range[1]
cup_bowl(width=1.0, height=1.0, x_base=1.0, y_base=10.0)

colfunc=colorRampPalette(c("black", pal_col[2]))
col_range=colfunc(5)
col_str=col_range[2]
cup_bowl(width=1.2, height=1.0, x_base=1.0, y_base=7.5)
col_str=col_range[3]
cup_bowl(width=1.5, height=1.0, x_base=1.0, y_base=5.0)
col_str=col_range[4]
cup_bowl(width=1.9, height=1.0, x_base=1.0, y_base=2.5)
col_str=col_range[5]
cup_bowl(width=2.5, height=1.0, x_base=1.0, y_base=0.0)


pal_col=rainbow(2)

labov=read.csv(paste0(ESEUR_dir, "developers/labov73.csv.xz"), as.is=TRUE)

plot(0, type="n",
	xaxs="i", yaxs="i",
	xlim=c(1.0, 2.5), ylim=c(0, 100),
	xlab="Relative width of container", ylab="Chosen (percentage)\n")

cup_food=subset(labov, container=="cup" & content=="food")
lines(cup_food$rel_width, cup_food$percent, col=pal_col[1])

bowl_food=subset(labov, container=="bowl" & content=="food")
lines(bowl_food$rel_width, bowl_food$percent, col=pal_col[2])


cup_neut=subset(labov, container=="cup" & content=="neutral")
lines(cup_neut$rel_width, cup_neut$percent, col=pal_col[1], lty=2)

bowl_neut=subset(labov, container=="bowl" & content=="neutral")
lines(bowl_neut$rel_width, bowl_neut$percent, col=pal_col[2], lty=2)

legend(x="topright", legend=c("Cup", "Bowl"), bty="n", fill=pal_col, cex=1.2)

