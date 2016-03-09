#
# proj-concur.R,  5 Mar 16
#
# Data from:
# Right on Time: Measuring, Modelling and Managing Time-Constrained Software Development
# Antony Lee Powell
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#

source("ESEUR_config.r")


plot_wide()
brew_col=rainbow_hcl(6)

# The following only works if every layer covers the layer beneath it
plot_fill=function(file_1, file_2, col_ind)
{
# The values in these files are x/y coordinates of plotted lines
fig_1=read.csv(paste0(ESEUR_dir, "projects/YCST/", file_1), as.is=TRUE)
fig_2=read.csv(paste0(ESEUR_dir, "projects/YCST/", file_2), as.is=TRUE)

polygon(c(fig_1$Time, rev(fig_2$Time)),
	c(fig_1$Effort, rev(fig_2$Effort)),
	col=brew_col[col_ind])
}

plot(0, 0, type="n",
	xlim=c(0, 84), ylim=c(0, 1600),
	xlab="Week", ylab="Effort (person hours)\n")

plot_fill("YCST-Fig31.base.csv.xz", "YCST-Fig31.A.csv.xz", 1)
plot_fill("YCST-Fig31.A.csv.xz", "YCST-Fig31.B.csv.xz", 2)
plot_fill("YCST-Fig31.B.csv.xz", "YCST-Fig31.C.csv.xz", 3)
plot_fill("YCST-Fig31.C.csv.xz", "YCST-Fig31.D.csv.xz", 4)
plot_fill("YCST-Fig31.D.csv.xz", "YCST-Fig31.non-proj.csv.xz", 5)
plot_fill("YCST-Fig31.non-proj.csv.xz", "YCST-Fig31.holiday.csv.xz", 6)

