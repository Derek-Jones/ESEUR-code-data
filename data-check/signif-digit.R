#
# signif-digit.R,  8 Jan 16
#
# Data from:
#
# The New C Standard
# Derek M. Jones
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


pal_col=rainbow(4)


plot(100*log10(1+1/(1:9)), type="l", col=pal_col[1],
	xlim=c(1, 15), ylim=c(0, 40),
	xlab="Digit", ylab="Percent occurrence\n")

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
			bty="n", fill=pal_col, cex=1.3)

