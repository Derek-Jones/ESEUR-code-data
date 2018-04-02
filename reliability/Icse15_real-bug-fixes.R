#
# Icse15_real-bug-fixes.R, 13 Mar 18
# Data from:
# An Empirical Study on Real Bug Fixes
# Hao Zhong and Zhendong Su
# via:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library(jsonlite)
library(plyr)


pal_col=rainbow(5)

commits=fromJSON(paste0(ESEUR_dir, "reliability/Icse15_real-bug-fixes.json.xz"))


plot_bug_or_fix=function(project_str, col_num)
{
proj=subset(commits, project == project_str)

# Assumes the complete json file.  To keep the size down the book's
# only contains this selection_criteria.
bug_or_fix=subset(proj, selection_criterion == "commit message contains bug or fix")

file_count=sapply(bug_or_fix$changed_files, function(X) length(X$name))

file_tab=count(file_count)
file_tab$freq_norm=100*file_tab$freq/max(file_tab$freq)

points(file_tab$x, file_tab$freq_norm, col=pal_col[col_num])

return(file_tab)
}


plot(0.1, type="n", log="y",
	yaxs="i",
	xlim=c(1, 9), ylim=c(1, 105),
	xlab="Files", ylab="Commits (normalised)\n")

aries=plot_bug_or_fix("aries", 1)
cassandra=plot_bug_or_fix("cassandra", 2)
derby=plot_bug_or_fix("derby", 3)
lucene=plot_bug_or_fix("lucene", 4)
mahout=plot_bug_or_fix("mahout", 5)


legend(x="topright", legend=c("Aries", "Cassandra", "Derby", "Lucene", "Mahout"), bty="n", fill=pal_col, cex=1.2)

# freq_mod=nls(freq_norm ~ a*x^b, data=derby[2:10, ], trace=TRUE,
# 		start=list(a=100, b=-2.0))
# 
# freq_pred=predict(freq_mod, newdata=data.frame(x=1:10), type="response")

lines(1:10, 100*(1:10)^(-2.1), col="grey")

