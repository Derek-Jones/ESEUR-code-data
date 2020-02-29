#
# glob-def-usage.R,  7 Feb 20
# Data from:
# Understanding Source Code Evolution Using Abstract Syntax Tree Matching
# Iulian Neamtiu and Jeffrey S. Foster and Michael Hicks
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG variables_C types_C functions_C LOC_global-variable variable_globals

source("ESEUR_config.r")


library("plyr")


gd=read.csv(paste0(ESEUR_dir, "sourcecode/glob-def-usage.csv.xz"), as.is=TRUE)

gd$Release.Date=as.Date(gd$Release.Date, format="%d/%m/%y")

# plot(gd$Release.Date, gd$Global.Variables)

plot(gd$LOC/1e3, gd$Global.Variables, type="n", log="x",
	xlab="KLOC", ylab="Global variables\n")

u_prog=unique(gd$Program)
pal_col=rainbow(length(u_prog))

gd$col_str=mapvalues(gd$Program, u_prog, pal_col)

d_ply(gd, .(Program), function(df) points(df$LOC/1e3, df$Global.Variables, col=df$col_str[1]))

legend(x="topleft", legend=u_prog, bty="n", fill=pal_col, cex=1.2)

