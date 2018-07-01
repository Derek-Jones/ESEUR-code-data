#
# github-lang-use.R, 11 Jul 17
#
# Data from:
# Popularity, interoperability, and impact of programming languages in 100,000 open source projects
# Tegawend\'{e} F. Bissyand\'{e} and Ferdian Thung and David Lo and Lingxiao Jiang and Laurent R\'{e}veill\`{e}re
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


git_lang=read.csv(paste0(ESEUR_dir, "sourcecode/github-lang-use.csv.xz"), as.is=TRUE)

git_lang=subset(git_lang, language != "")


count_proj_lang=function(df)
{
return(nrow(df))
}


t=daply(git_lang, .(program), count_proj_lang)

# Plot complains about the log option unless the value of table is converted
plot(as.vector(table(t)), log="y", type="b", col=point_col,
	xlab="\nLanguages used", ylab="Projects\n")

