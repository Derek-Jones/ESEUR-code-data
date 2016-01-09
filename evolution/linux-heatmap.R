#
# linux-heatmap.R,  4 Mar 15
#
# Data from:
# Analysis of the Linux Kernel Evolution Using Code Clone Coverage
# Simone Livieri†and Yoshiki Higo†and Makoto Matsushita†and Katsuro Inoue†
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("bitops")
library("plyr")
library("png")


# Map three RGB values to single integer value.
# Every RGB primary color can only have one of 256 values.
map_RGB=function(color)
{
return(bitOr(as.numeric(255*color[ , 1]),
             bitOr(bitShiftL(as.numeric(255*color[ , 2]), 8),
                   bitShiftL(as.numeric(255*color[ , 3]), 16))))
}


hm=readPNG(paste0(ESEUR_dir, "evolution/heatmap2.png"), FALSE)

# Limits of image
xbounds=c(1, ncol(hm))
ybounds=c(1, nrow(hm))

plot(1, type="n",
	xaxt="n", yaxt="n",
	xlim=xbounds, ylim=ybounds,
	xlab="", ylab="")

rasterImage(hm, xbounds[1], ybounds[1], xbounds[2], ybounds[2])

# Two ends of RGB colors
black_white_RGB=rbind(c(0, 0, 0),
		      c(1, 1, 1))
black_white=map_RGB(black_white_RGB)
white_RGB=black_white[2]

# Strip containing heatmap scale
# Offsets found by looking for black line at either end
hm_RGB=hm[5925, 580:3204, ]

# Map three RGB values to single number and find offset on 0..1 scale
hm_scale=data.frame(RGB=map_RGB(hm_RGB),
			scale=(1:nrow(hm_RGB))/nrow(hm_RGB))
# Shink duplicate sequence of rows to a single row
uniq_scale=hm_scale[with(hm_scale,
				c((RGB[-1] != head(RGB, n=-1)), TRUE)), ]
# Make sure white is zero
uniq_scale$scale[uniq_scale$RGB == white_RGB]=0


# Cut out plot from surrounding axis labels
# x/y found by trial and error
th=hm[1:5450,551:6000,]


# Find column start, get row start for free
col_edge=aaply(th, 1, function(df) (df[ , 1] != df[ , 2]))
# Last value is top of plot
# Some df vectors don't contain TRUE, insert one so there is always
# a value to return (otherwise aaply gets upset).
# Subtract 1 to offset the dummy TRUE we inserted.
t1_ce=aaply(col_edge, 1, function(df) tail(which(c(TRUE, df)), n=1))-1
# Remove the zero entries
t2_ce=t1_ce[t1_ce != 0]
# Shrink sequence of multiple instances of a particular value to single value
ce_offset=t2_ce[c((t2_ce[-1] != head(t2_ce, n=-1)), TRUE)]
ce_row=as.numeric(names(ce_offset))

col_map=aaply(th, 1, map_RGB)

# Can now extract RGB value at one point for each revision
col_val=col_map[ce_row, ce_offset]

# Map RGB to 0..1 scale
# Giving the percentage in current release carried over from previous releases
t1_v=aaply(col_val, 1, function(df) t=mapvalues(df, from=uniq_scale$RGB,
							to=uniq_scale$scale,
							warn_missing=FALSE))

# Rotate clockwise by 90 degrees
version_p=t(apply(t1_v, 2, rev))

write.csv(version_p, file="linux-src-evol.csv.xz", row.names=FALSE)

pal_col=rainbow(30, end=26/30)
#pal_col=heat.colors(30)
# Add white for the lowest value
pal_col=c("#FFFFFFFF", pal_col)

image(version_p, col=pal_col)

