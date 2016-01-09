#
# J20_paper.R,  3 Feb 14
#
# Data from:
# Power Variability in Contemporary DRAMs
# Mark Gottscho and Abde Ali Kagalwalla and Puneet Gupta
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


ssd=read.csv(paste0(ESEUR_dir, "benchmark/J20_paper.csv.xz"), as.is=TRUE)

M1=subset(ssd, model == "M1")

mean_sd=function(df)
{
c(mean(df), sd(df), 100*sd(df)/mean(df))
}

mean_sd(M1$write)
mean_sd(M1$read)
mean_sd(M1$idle)


