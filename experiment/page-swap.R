#
# page-swap.R, 20 Jun 16
# Data from:
# A multi-factor paging experiment: I. The experiment and the conclusions
# R. F. Tsao and L. W. Comeau and B. H. Margolin
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")
library("reshape2")


ps=read.csv(paste0(ESEUR_dir, "experiment/page-swap.csv.xz"), as.is=TRUE)

map_gp=function(df)
{
df$loadseg=df$swaps[1]
df$pages=as.numeric(df$swaps[2])
df=df[-c(1, 2), ]
df$swaps=as.numeric(df$swaps)

return(df)
}

# Convert data from form it appears in the paper to something glm can use
t=melt(ps, id.vars=c("alg", "size"),
		value.name="swaps")

swaps=ddply(t, .(variable), map_gp)
swaps$variable=NULL


# Additive model.  LRU gives lowest page swap.
ps_a_mod=glm(swaps ~ (alg+size+loadseg+pages)^2-alg:loadseg, data=swaps)


# Multiplicarive model gives a much better fit.
# LRU's advantage comes via interaction with pages
ps_m_mod=glm(swaps ~ (alg+size+loadseg+pages)^2, data=swaps, family=poisson)

# No interactions
ps_m_mod=glm(swaps ~ alg+size+loadseg+pages, data=swaps, family=poisson)

summary(ps_m_mod)

