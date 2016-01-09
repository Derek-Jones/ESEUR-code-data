#
# male-female-IQ.R,  2 Jan 14
#
# Data from:
# Population sex differences in IQ at age 11: the Scottish mental survey 1932
# Deary, Thorpe, Wilson, Starr and Whalley
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

m_f_IQ=read.csv(paste0(ESEUR_dir, "developers/misc/male-female-IQ.csv.xz"), as.is=TRUE)

brew_col=rainbow(2)

plot(m_f_IQ$IQ, 100*m_f_IQ$boy/(m_f_IQ$boy+m_f_IQ$girl),
	type="l", col=brew_col[1],
	ylim=c(40, 60),
	xlab="IQ", ylab="Gender percentage within given IQ band")

lines(m_f_IQ$IQ, 100*m_f_IQ$girl/(m_f_IQ$boy+m_f_IQ$girl), col=brew_col[2])

legend(x="top",legend=c("Boy", "Girl"), bty="n", fill=brew_col)

