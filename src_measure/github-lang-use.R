#
# github-lang-use.R,  6 Dec 15
#
# Data from:
# Popularity, interoperability, and impact of programming languages in 100,000 open source projects
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


git_lang=read.csv(paste0(ESEUR_dir, "src_measure/github-lang-use.csv.xz"), as.is=TRUE)

git_lang=subset(git_lang, language != "")


count_proj_lang=function(df)
{
return(nrow(df))
}


t=daply(git_lang, .(program), count_proj_lang)

# Plot complains about the log option unless the value of table is converted
plot(as.vector(table(t)), log="y", type="b",
	xlab="\nNumber of languages used", ylab="Number of projects\n")

