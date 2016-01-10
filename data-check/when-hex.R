#
# when-hex.R, 10 Jan 15
#
# Data from:
#
# Google books project
# +
# The New C Standard
# Derek M. Jones
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(1, 1)

pal_col=rainbow(2)

c_hex=read.csv(paste0(ESEUR_dir, "data-check/srchex.csv"), as.is=TRUE)
g_hex=read.csv(paste0(ESEUR_dir, "data-check/googlehex.csv"), as.is=TRUE)

plot(c_hex$hex, 100*c_hex$c_cnt/sum(c_hex$c_cnt), col=pal_col[1],
	ylim=c(0, 22),
	xlab="First hex digit", ylab="Percent occurrence\n")

points(g_hex$hex, g_hex$g_percent, col=pal_col[2])

legend(x="top", legend=c("C source", "Google books"),
				bty="n", fill=pal_col, cex=1.3)

