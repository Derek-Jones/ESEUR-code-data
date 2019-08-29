#
# outflux_net-ubuntu.R, 23 Jul 19
# Data from:
# Ubuntu Security Hardening Statistics (amd64)
# Kees Cook
# https://wiki.ubuntu.com/Security/Features
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG  Ubuntu security program_hardening


source("ESEUR_config.r")


library("plyr")


prog_lines=function(df)
{
lines(df$date, df$programs, col=df$col_str[1])
}


outf=read.csv(paste0(ESEUR_dir, "ecosystems/outflux_net-ubuntu.csv.xz"), as.is=TRUE)
outf$date=as.Date(as.character(outf$date), format="%Y%m%d")

u_hard=unique(outf$hardening)

pal_col=rainbow(length(u_hard))
outf$col_str=mapvalues(outf$hardening, u_hard, pal_col)


plot(outf$date[1], 1, type="n", log="y",
	xlim=range(outf$date), ylim=c(1, max(outf$programs)),
	xlab="Date", ylab="Programs\n")

d_ply(outf, .(hardening), prog_lines)

legend(x="bottomright", legend=u_hard, bty="n", fill=pal_col, cex=1.3)

