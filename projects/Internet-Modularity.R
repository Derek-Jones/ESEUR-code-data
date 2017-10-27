#
# Internet-Modularity.R,  8 Oct 17
# Data from:
# Modularity and the Evolution of the Internet
# Timothy Simcoe
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("lattice")


i_mod=read.csv(paste0(ESEUR_dir, "projects/Internet-Modularity.csv.xz"),
		as.is=TRUE, row.names=1, check.names=FALSE)

i_mod=as.matrix(i_mod)
i_mod=i_mod[rev(seq_len(nrow(i_mod))), ]

t=levelplot(i_mod,
                col.regions=rainbow(100, start=0.12, end=0.85),
                xlab=list(label="From document", cex=0.90),
                ylab=list(label="To document", cex=0.90),
                colorkey=NULL, # Numeric values remove the need for legend
                scales=list(x=list(cex=0.65, rot=35), y=list(cex=0.65)),
                panel=function(...)
                        {
                        panel.levelplot(...)
                        panel.text(1:6, rep(1:6, each=6), i_mod, cex=0.7)
                        })

plot(t, panel.height=list(3.8, "cm"), panel.width=list(6.2, "cm"))

