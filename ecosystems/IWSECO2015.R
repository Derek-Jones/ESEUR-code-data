#
# IWSECO2015.R,  2 Aug 19
# Data from:
# On the Development and Distribution of R Packages: {An} Empirical Analysis of the R Ecosystem
# Alexandre Decan and Tom Mens and Maelick Claes and Philippe Grosjean
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG CRAN Bioconductor Github_R packages_R


source("ESEUR_config.r")


library("VennDiagram")


pal_col=rainbow_hcl(3)


rp=read.csv(paste0(ESEUR_dir, "ecosystems/IWSECO2015.csv.xz"), as.is=TRUE)

bcg=table(rp$bioconductor,rp$cran,rp$github)

# This package uses the grid package for its graphics
grid.newpage()
vp=viewport(width=0.4, height=0.4)
pushViewport(vp)

venn.plot = draw.triple.venn(
                area1 = bcg[2, 1, 1]+bcg[2, 2, 1]+bcg[2, 1, 2]+bcg[2, 2, 2],
                area2 = bcg[1, 2, 1]+bcg[2, 2, 1]+bcg[1, 2, 2]+bcg[2, 2, 2],
                area3 = bcg[1, 1, 2]+bcg[1, 2, 2]+bcg[2, 1, 2]+bcg[2, 2, 2],
                n12 = bcg[2, 2, 1]+bcg[2, 2, 2],
                n13 = bcg[2, 1, 2]+bcg[2, 2, 2],
                n23 = bcg[1, 2, 2]+bcg[2, 2, 2],
                n123 = bcg[2, 2, 2],
                label.col=c("yellow", "green", "yellow", "red", "blue", "red", "yellow"),
                category = c("Bioconductor", "CRAN", "Github"),
                fill = c(pal_col[2], pal_col[3], pal_col[1]),
                lty = "blank",
#               lwd=rep(1.5, 3),
# Scaling does not have the desired effect,
# which might not be mathematically possible anyway.
                euler.d=TRUE, scaled=TRUE, overrideTriple=TRUE,
                cex = 1.2,
                cat.cex = 1.3,
                # cat.col = c("blue", "red", "green"),
                cat.dist = c(0.01, 0.02, 0.01),
                cat.pos = c(165, 200, 0),
                rotation.degree=180
             )
grid.draw(venn.plot)
popViewport()


