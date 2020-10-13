#
# msr2020_pfeiffer.R, 30 Sep 20
# Data from:
# What constitutes Software? {An} Empirical, Descriptive Study of Artifacts
# Rolf-Helge Pfeiffer
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG source-code_kind project_file-kind

source("ESEUR_config.r")

library("plyr")
library("zoo")


par(mar=MAR_default+c(0.0, 0.7, 0, 0))

pal_col=rainbow(4)

# For each repo, sum the number of files within each category.
count_cat=function(df)
{
repo=data.frame(owner=df$owner)
repo$Code=sum(df$count[which(df$category == "Code")])
repo$Data=sum(df$count[which(df$category == "Data")])
repo$Documentation=sum(df$count[which(df$category == "Documentation")])
repo$Other=sum(df$count[which(df$category == "Other")])
repo$Total=sum(df$count)

return(repo)
}

# For repos containing a given number of total files,
# return the mean of each category.
files_mean=function(df)
{
repo=data.frame(owner=df$owner[1])
repo$Total=df$Total[1]
repo$Code=mean(df$Code)
repo$Data=mean(df$Data)
repo$Documentation=mean(df$Documentation)
repo$Other=mean(df$Other)

return(repo)
}



fk=read.csv(paste0(ESEUR_dir, "sourcecode/msr2020_pfeiffer.csv.xz"), as.is=TRUE)

# kind_cnt=count(fk$kind)
# 
# plot(sort(kind_cnt$freq),
# 	yaxs="i",
# 	xlab="", ylab="Occurrence (percentage)\n")


Code=c("source code", "spec. source code", "script", "binary code",
		"build", "infrastructure")
Data=c("image", "video", "music", "configuration", "database", "font",
		"archive", "markup", "document", "app data")
Documentation=c("prose", "legalese")
Other=c("") # empty appears to be Other

f_kind=c(Code, Data, Documentation, Other)
f_cat=c(rep("Code", length(Code)), rep("Data", length(Data)),
	rep("Documentation", length(Documentation)), rep("Other", length(Other)))

fk$category=mapvalues(fk$kind, f_kind, f_cat)


repo_files=ddply(fk, .(owner), count_cat)

# plot(repo_files$Total, repo_files$Code, log="xy", col=pal_col[1],
# 	xlab="Total files", ylab="Files\n")
# points(repo_files$Total, repo_files$Data, col=pal_col[2])
# points(repo_files$Total, repo_files$Documentation, col=pal_col[3])
# points(repo_files$Total, repo_files$Other, col=pal_col[4])


repo_mean=ddply(repo_files, .(Total), files_mean)

# plot(repo_mean$Total, repo_mean$Code, log="xy", col=pal_col[1],
# 	xlab="Project files (total)", ylab="Files\n")
# points(repo_mean$Total, repo_mean$Data, col=pal_col[2])
# points(repo_mean$Total, repo_mean$Documentation, col=pal_col[3])
# points(repo_mean$Total, repo_mean$Other, col=pal_col[4])

# If any numeric analysis is done, the rolling mean needs to be weighted
# by the number of repos within each total containe din the window.
# Changing the window width, upto 7, has little effect on the visual appearance.
#
total_files=tail(head(repo_mean$Total, n=-1), n=-1)
plot(total_files,rollmean(repo_mean$Code, k=3)/total_files, log="xy", col=pal_col[1],
	yaxs="i",
	ylim=c(1e-3, 1),
	xlab="Project files (total)", ylab="Fraction of files\n\n")
points(total_files, rollmean(repo_mean$Data, k=3)/total_files, col=pal_col[2])
points(total_files, rollmean(repo_mean$Documentation, k=3)/total_files, col=pal_col[3])
points(total_files, rollmean(repo_mean$Other, k=3)/total_files, col=pal_col[4])

legend(x="left", legend=c("Code", "Data", "Documentation", "Other"), bty="n", fill=pal_col, cex=1.2)

