#
# os-features.R, 27 Mar 16
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

brew_col=rainbow_hcl(2)

# boxplot(Original ~ program, data=n_t, notch=TRUE)

t=bwplot(value ~ variable | program, data=m_t,
		panel=panel.violin, col="yellow",
                par.strip.text=list(cex=0.75),
                scales=list(y=list(cex=0.8)),
		ylab="Normalised performance")

plot(t, panel.height=list(1.5, "cm"))


