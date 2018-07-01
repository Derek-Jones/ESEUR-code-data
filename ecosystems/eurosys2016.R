#
# eurosys2016.R, 29 Apr 18
# Data from:
# {POSIX} Abstractions in Modern Operating Systems: {The} Old, the New, and the Missing
# Vaggelis Atlidakis and Jeremy Andrus and Roxana Geambasu and Dimitris Mitropoulos and Jason Nieh
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)


static=read.csv(paste0(ESEUR_dir, "ecosystems/static_POSIX.csv.xz"), as.is=TRUE)

plot(sort(static$Android, decreasing=TRUE), type="l", log="y", col=pal_col[1],
	xlab="Function rank", ylab="Packages")
lines(sort(static$Ubuntu, decreasing=TRUE), col=pal_col[2])

legend(x="topright", legend=c("Android apps", "Ubuntu packages"), bty="n", fill=pal_col, cex=1.2)

# For the dynamic study we trace: 372 out of the 821 C
# POSIX functions implemented in Android; 462 out of the
# 1,115 C POSIX functions implemented in Ubuntu; and 897
# out of the 1,177 C POSIX functions implemented in OS X.
# 
# Google Play (45 apps), Apple AppStore (10 apps), and Ubuntu Software Center (45 apps).
# 
# dynamic=read.csv(paste0(ESEUR_dir, "ecosystems/dynamic_POSIX.csv.xz"), as.is=TRUE)
# 
# pal_col=rainbow(3)
# 
# plot(sort(dynamic$Android_Invocations, decreasing=TRUE), type="l", log="y", col=pal_col[1],
# 	xlim=c(1, 250),
# 	xlab="Rank", ylab="Packages\n")
# lines(sort(dynamic$Ubuntu_Invocations, decreasing=TRUE), col=pal_col[2])
# lines(sort(dynamic$OSX_Invocations, decreasing=TRUE), col=pal_col[3])
# 
# legend(x="topright", legend=c("Android apps", "Ubuntu packages", "OS X"), bty="n", fill=pal_col, cex=1.2)
# 

