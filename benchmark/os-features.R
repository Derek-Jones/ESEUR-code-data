#
# os-features.R, 28 Feb 14
#
# Data from:
# Performance Variance Evaluation on Mozilla Firefox
# Jan Larres
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("plyr")
library("reshape2")
library("lattice")


# Normalised all results by the original data
normalise_results=function(df)
{
t=mean(df$with_noise)
df$Original=df$with_noise/t
df$Stablised=df$less_noise/t

return(df)
}


os_features=read.csv(paste0(ESEUR_dir, "benchmark/os-features.csv.xz"), as.is=TRUE)

n_t=ddply(os_features, .(program), normalise_results)

# Display first six sets of results
n_t=subset(n_t, program %in% unique(n_t$program)[1:6])

n_t$with_noise=NULL
n_t$less_noise=NULL
m_t=melt(n_t, id.vars="program")

brew_col=rainbow_hcl(4)

# boxplot(Original ~ program, data=n_t, notch=TRUE)

p=bwplot(value ~ variable|program, data=m_t, notch=TRUE,
	ylab="Normalised performance", fil=brew_col)

print(p)

