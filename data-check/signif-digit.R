#
# signif-digit.R, 29 Feb 20
#
# Data from:
# The New C Standard: An Economic and Cultural Commentary
# Derek M. Jones
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG C_literal literal_first-digit literal_Benford

source("ESEUR_config.r")


pal_col=rainbow(4)


plot(100*log10(1+1/(1:9)), type="l", col=pal_col[1],
	xaxt="n", yaxs="i",
	xlim=c(1, 15), ylim=c(0, 45),
	xlab="Digit", ylab="Numeric literal (percent)\n")

axis(1, at=0:15, label=c(as.character(0:9), "A", "B", "C", "D", "E", "F"))

plot_ben=function(digit_cnt, color)
{
total_digit=sum(digit_cnt$occur)

lines(100*digit_cnt$occur/total_digit, col=color)
}


digit_cnt=read.csv(paste0(ESEUR_dir, "data-check/benfordflt.csv.xz"), as.is=TRUE)
plot_ben(digit_cnt, pal_col[2])

digit_cnt=read.csv(paste0(ESEUR_dir, "data-check/benfordint.csv.xz"), as.is=TRUE)
plot_ben(digit_cnt, pal_col[3])

digit_cnt=read.csv(paste0(ESEUR_dir, "data-check/benfordhex.csv.xz"), as.is=TRUE)
plot_ben(digit_cnt, pal_col[4])

legend(x="topright", legend=c("Benford's law", "Floating", "Integer", "Hexadecimal"),
			bty="n", fill=pal_col, cex=1.2)

