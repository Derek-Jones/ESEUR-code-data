#
# when-hex.R, 18 Aug 16
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


pal_col=rainbow(2)

c_hex=read.csv(paste0(ESEUR_dir, "data-check/srchex.csv.xz"), as.is=TRUE)
g_hex=read.csv(paste0(ESEUR_dir, "data-check/googlehex.csv.xz"), as.is=TRUE)

plot(c_hex$hex, 100*c_hex$c_cnt/sum(c_hex$c_cnt), col=pal_col[1], type="b",
	ylim=c(0, 22), xaxt="n",
	xlab="First hex digit", ylab="Percent occurrence\n")
axis(1, at=seq(2, 14, by=2), labels=c("2", "4", "6", "8", "a", "c", "e"))

points(g_hex$hex, g_hex$g_percent, col=pal_col[2], type="b")

legend(x="top", legend=c("C source", "Google books"),
				bty="n", fill=pal_col, cex=1.3)

