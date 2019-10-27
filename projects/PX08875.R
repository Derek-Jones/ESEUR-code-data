#
# PX08875.R, 22 Sep 19
# Data from:
# Opus Development Postmortem
# Peter Jackson
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Microsoft project_staffing effort_estimate


source("ESEUR_config.r")


plot_next=function(X)
{
y_jit=0.2*((X%%5)-2.5)
x_jit=4.5*((X%%8)-4)

x_p=px$Days_to_ship[(X-1):X]
y_p=px$FTE[(X-1):X]
lines(x_p, y_p, col=pal_col[X])
text(x_p[2]+x_jit, y_p[2]+y_jit, X, cex=1.0)
}


px=read.csv(paste0(ESEUR_dir, "projects/PX08875.csv.xz"), as.is=TRUE)

pal_col=rainbow(nrow(px))

plot(1, type="n",
	xaxs="i",
	xlim=range(px$Days_to_ship), ylim=range(px$FTE),
	xlab="Days to ship", ylab="Full time engineer")

text(px$Days_to_ship[1], px$FTE[1], "1")

dummy=sapply(2:nrow(px), plot_next)

