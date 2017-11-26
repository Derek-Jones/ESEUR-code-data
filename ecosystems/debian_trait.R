#
# debian_trait.R, 22 Nov 17
# Data from:
# From computer operating systems to biodiversity: co-emergence of ecological and evolutionary patterns
# Petr Keil and Joanne M. Bennett and B{\'e}renger Bourgeois and Gabriel E. Garc{\'a}-Pe\~{n}a and A. Andrew M. MacDonald and Carsten Meyer and Kelly S. Ramirez and Benjamin Yguel
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("ape")


plot_layout(1, 1, default_width=1.3*ESEUR_default_width,
                  default_height=2.0*ESEUR_default_height)


deb=read.csv(paste0(ESEUR_dir, "ecosystems/debian_trait_data.csv.xz"), as.is=TRUE)

deb$package=NULL
deb$Debian=NULL # A more visually appealing tree without this

deb_dist=dist(t(deb))
deb_phy=nj(deb_dist)
plot(deb_phy, cex=1.1, edge.color=point_col)

