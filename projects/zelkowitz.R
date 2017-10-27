#
# zelkowitz.R,  8 Oct 17
#
# Data from:
# Resource Utilization during Software Development
# Marvin V. Zelkowitz
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("lattice")


zel=read.csv(paste0(ESEUR_dir, "projects/zelkowitz.csv.xz"), as.is=TRUE)

geo_mean=function(X)
{
# Some values are zero, which skews the geometric mean calculation.
X[X < 1e-4]=0.01
return(prod(X)^(1/length(X)))
}


mean_val=function(phase)
{
# Percentages, so have to use geometric rather than arithmetic mean
col_means=apply(subset(zel, Activity == phase)[-(1:2)], MARGIN=2, geo_mean)
# design_sd=apply(subset(zel, Activity == phase)[-(1:2)], MARGIN=2, sd)

return(round(col_means, digits=1))
}


i_mod=matrix(data=0, nrow = 4, ncol = 4)
colnames(i_mod)=c("Design", "Coding", "Integration", "Acceptance\ntesting")
rownames(i_mod)=c("Design", "Coding\nTesting", "Integration\ntesting", "Other")

i_mod[, 1]=mean_val("Design")
i_mod[, 2]=mean_val("Coding.testing")
i_mod[, 3]=mean_val("Integration.test")
i_mod[, 4]=mean_val("Other")

# (1, 1) is bottom left and we want it in the top left.
i_mod=i_mod[, rev(seq_len(nrow(i_mod)))]

t=levelplot(i_mod,
                col.regions=rainbow(100, start=0.12, end=0.85),
                xlab=list(label="Phase work overlapped with", cex=0.80),
                ylab=list(label="", cex=0.90),
                colorkey=NULL, # Numeric values remove the need for legend
                scales=list(x=list(cex=0.65, rot=35), y=list(cex=0.65)),
                panel=function(...)
                        {
                        panel.levelplot(...)
                        panel.text(1:4, rep(1:4, each=4), i_mod, cex=0.7)
                        })

plot(t, panel.height=list(3.8, "cm"), panel.width=list(6.2, "cm"))


