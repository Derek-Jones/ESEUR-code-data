#
# msr2018b_evol.R, 10 Apr 19
# Data from:
# Understanding the Usage, Impact, and Adoption of Non-{OSI} Approved Licenses
# R\^{o}mulo Meloca and Gustavo Pinto and Leonardo Baiser and Marco Mattos and Ivanilton Polato and Igor Scaliante Wiese and Daniel M. German
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG

source("ESEUR_config.r")


# Data in paper is organized by From/To, rather than To/From in book
le=read.csv(paste0(ESEUR_dir, "economics/msr2018b_evol.csv.xz"), as.is=TRUE)

npm=subset(le, Network == "NPM")
npm$Network=NULL
rownames(npm)=npm$From.To
npm$From.To=NULL

rs=rowSums(npm)

le_perc=t(sapply(1:nrow(npm), function(X) 100*npm[X, ]/rs[X]))
rownames(le_perc)=colnames(le_perc)


