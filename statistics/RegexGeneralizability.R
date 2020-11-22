#
# RegexGeneralizability.R, 25 Apr 20
# Data from:
# Testing Regex Generalizability And Its Implications {A} Large-Scale Many-Language Measurement Study
# James C. Davis and Daniel Moyer and Ayaan M. Kazerouni and Dongyoon Lee
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human regex_use

source("ESEUR_config.r")


library("ascii")
library("plyr")


# Extract basic information on each language
lang_sample_size=function(lang)
{
LR_lang=subset(RG, grepl(lang, LangsStatic))$csharpRegexLen
l_mean=mean(LR_lang)

return(data.frame(Language=lang, mean=l_mean, sample_size=length(LR_lang),
			stringsAsFactors=FALSE))
}


boot_mean=function(measure, sample_size)
{
samp_ind=sample(1:length(measure), size=sample_size, replace=TRUE)

return(mean(measure[samp_ind]))
}


# Bootstrap RegexLen for each language's sample size
RegexLen_boot=function(df)
{
mean_rep=replicate(4999, boot_mean(RG$csharpRegexLen, df$sample_size))

# Probability that the actual mean is less than a bootstrapped mean
df$Probability=100*length(which(df$mean < mean_rep))/length(mean_rep)

return(df)
}


# A cut down version of the much larger original
RG=read.csv(paste0(ESEUR_dir, "statistics/RegexGeneralizability.csv.xz"), as.is=TRUE)


lang_str=c("go", "java", "javascript",
		"perl", "php", "python", "ruby", "rust")

# The sample size varies between languages
lang_info=adply(lang_str, 1, lang_sample_size)

RegexLen=ddply(lang_info, .(sample_size), RegexLen_boot)

RegexLen$X1=NULL

print(ascii(RegexLen, include.rownames=FALSE, digits=1,
	colnames=c("Language", "Mean length", "Sample size", "Bootstrap probability"),
        frame="topbot", grid="none"))

#
# fishing.R, 11 Feb 20
#
# Code to convert the original json to csv
# 
# library("jsonlite")
# 
# 
# sort_lang=function(langs)
# {
# # Some values are NULL, which disappears when processed by unlist.
# langs[sapply(langs, function(X) (length(X) == 0))]=NA
# 
# # t=strsplit(unlist(langs), ",")
# # Order languages
# s_langs=sapply(langs, function(X) paste0(sort(X), collapse=","))
# 
# return(s_langs)
# }
# 
# 
# re=fromJSON("LF-measured-regexes.json", flatten=TRUE, simplifyDataFrame=TRUE)
# 
# re$LangsStatic=sort_lang(re$origLangsDynamic)
# re$LangsStatic=sort_lang(re$origLangsStatic)
# 
# re$origLangsDynamic=NULL
# re$origLangsStatic=NULL
# 
# write.csv(re, file="/usr1/ESEUR/LF.csv", row.names=FALSE)
# 
