#
# oopsla17b.R, 21 Jun 18
# Data from:
# D{\'e}j{\`a}Vu}: {A} Map of Code Duplicates on {GitHub}
# Cristina V. Lopes and Petr Maj and Pedro Martins and Vaibhav Saini and Di Yang and Jakub Zitny and Hitesh Sajnani and Jan Vitek
#
# To reduce file size,
# the 9,157,622 points were sampled to produce 1,000,000 points.
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG github python source-code clone project file


source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(2)

fd=read.csv(paste0(ESEUR_dir, "sourcecode/oopsla17b.csv.xz"), as.is=TRUE)


# t=count(fd$Occur)
# plot(t, log="xy",
# 	xlim=c(1, 1e4))

unique_files=count(fd$SLOC)
all_files=count(rep(fd$SLOC, fd$Occur))
plot(all_files, log="xy", col=pal_col[1],
	xaxs="i",
	xlim=c(0.9, 1e4),
	xlab="SLOC", ylab="Files")

points(unique_files, col=pal_col[2])

legend(x="bottomleft", legend=c("All files", "Unique files"), bty="n", fill=pal_col, cex=1.2)

