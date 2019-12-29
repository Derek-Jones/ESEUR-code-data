#
# error-freq.R, 28 Dec 19
# Data from:
# Frequency Distribution of Error Messages
# David Pritchard
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG student_mistake compiler_messages Java_mistake Python_mistake


source("ESEUR_config.r")


pal_col=rainbow(2)


ef=read.csv(paste0(ESEUR_dir, "sourcecode/error-freq.tsv"), as.is=TRUE, sep="\t")

Java=subset(ef, Lang == "Java")
Python=subset(ef, Lang == "Python")

plot(Java$Occurrences, log="xy", col=pal_col[1],
	xlab="Error message rank", ylab="Occurrences\n")
points(Python$Occurrences, col=pal_col[2])

legend(x="bottomleft", legend=c("Java", "Python"), bty="n", fill=pal_col, cex=1.2)

