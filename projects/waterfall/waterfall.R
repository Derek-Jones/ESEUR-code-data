#
# waterfall.R, 23 Nov 13
#
# Data from:
# Resource Utilization during Software Development
# Marvin V. Zelkowitz
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("plyr")


zel=read.csv(paste0(ESEUR_dir, "projects/waterfall/zelkowitz.csv.xz"), as.is=TRUE)

brew_col=rainbow_hcl(4)

plot_breakdown=function(phase, offset, line_col)
{
design_means=colMeans(subset(zel, Activity == phase)[3:6])
a_ply(1:4, 1,
	 function(X)
	 {
	 rect(X-design_means[X]/200, offset-0.03,
              X+design_means[X]/200, offset+0.03,
				col=line_col)
	 lines(c(X-design_means[X]/200, X+design_means[X]/200),
				c(offset, offset), col=line_col, lend=1)
	 text(X, offset+0.1, labels=as.character(signif(design_means[X],
					digits=3)), cex=1.3)
	 })
}

plot(1:4, 1:4, axes=FALSE, type="n",
      xlab="Phases work overlapped with", ylab="Work phase\n",
      xlim=c(0.5, 4.5), ylim=c(1.0, 4.2))

axis(1, at=c(1, 2, 3, 4), labels=c("Design", "Coding", "\nIntegration\ntesting", "\nAcceptance\ntesting"))
axis(2, at=c(4, 3, 2, 1), labels=c("Design", "Coding\nTesting", "Integration\ntesting", "Other"))

plot_breakdown("Design", 4, brew_col[1])
plot_breakdown("Coding.testing", 3, brew_col[2])
plot_breakdown("Integration.test", 2, brew_col[3])
plot_breakdown("Other", 1, brew_col[4])

