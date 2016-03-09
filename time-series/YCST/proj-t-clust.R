#
# proj-t-clust.R,  5 Mar 16
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


library("TSclust")

plot_layout(3, 1)
brew_col=rainbow_hcl(8)


get_effort=function(file_1, file_2)
{
# The values in these files are x/y coordinates of plotted lines.
# Data was extracted visually, so need to interpolate to discrete time points
discrete_vals=function(fig)
   {
   d_fun=approxfun(fig$Week, fig$Effort, rule=2)
   d_time=as.integer(min(fig$Week)-0.5):as.integer(max(fig$Week)+0.5)
   return(data.frame(Week=d_time, Effort=d_fun(d_time)))
   }

fig_1=read.csv(paste0(ESEUR_dir, "time-series/YCST/", file_1), as.is=TRUE)
fig_2=read.csv(paste0(ESEUR_dir, "time-series/YCST/", file_2), as.is=TRUE)

d_fig_1=discrete_vals(fig_1)
d_fig_2=discrete_vals(fig_2)

t_overlap=intersect(d_fig_1$Week, d_fig_2$Week)

# Max 86 weeks
effort_diff=rep(0, 86)
effort_diff[t_overlap]=d_fig_2$Effort[t_overlap]-d_fig_1$Effort[t_overlap]

return(effort_diff)
}


softw_req=get_effort("Fig32.zeroes.csv", "Fig32.sw_req.csv")
top_lev_design=get_effort("Fig32.sw_req.csv", "Fig32.tlev-design.csv")
coding=get_effort("Fig32.tlev-design.csv", "Fig32.code.csv")
low_lev_test=get_effort("Fig32.code.csv", "Fig32.low-test.csv")
req_test=get_effort("Fig32.low-test.csv", "Fig32.req-test.csv")
sys_acc_test=get_effort("Fig32.req-test.csv", "Fig32.sys-acc-test.csv")
manage=get_effort("Fig32.sys-acc-test.csv", "Fig32.manage.csv")
hol_nonproj=get_effort("Fig32.manage.csv", "Fig32.hol-nonproj.csv")


all_effort=cbind(softw_req, top_lev_design, coding, low_lev_test,
			req_test, sys_acc_test, manage, hol_nonproj)


# COR  and EUCL are two of the 22 possible METHODs (which must be in UPPER case)
eff_dist=diss(t(all_effort), METHOD="COR")
plot(hclust(eff_dist), main="", sub="", cex=1.4,
	xlab="", ylab="Correlation distance\n")
eff_dist=diss(t(all_effort), METHOD="EUCL")
plot(hclust(eff_dist), main="", sub="", cex=1.4,
	xlab="", ylab="Euclidean distance\n")

# The following only works if every layer covers the layer beneath it
plot_fill=function(file_1, file_2, col_ind)
{
fig_1=read.csv(paste0(ESEUR_dir, "time-series/YCST/", file_1), as.is=TRUE)
fig_2=read.csv(paste0(ESEUR_dir, "time-series/YCST/", file_2), as.is=TRUE)

polygon(c(fig_1$Week, rev(fig_2$Week)),
	c(fig_1$Effort, rev(fig_2$Effort)),
	col=brew_col[col_ind])
}

plot(0, 0, type="n",
	xlim=c(0, 85), ylim=c(0, 1600),
	xlab="Week", ylab="Effort (person hours)\n")

plot_fill("Fig32.zeroes.csv", "Fig32.sw_req.csv", 1)
plot_fill("Fig32.sw_req.csv", "Fig32.tlev-design.csv", 2)
plot_fill("Fig32.tlev-design.csv", "Fig32.code.csv", 3)
plot_fill("Fig32.code.csv", "Fig32.low-test.csv", 4)
plot_fill("Fig32.low-test.csv", "Fig32.req-test.csv", 5)
plot_fill("Fig32.req-test.csv", "Fig32.sys-acc-test.csv", 6)
plot_fill("Fig32.sys-acc-test.csv", "Fig32.manage.csv", 7)
plot_fill("Fig32.manage.csv", "Fig32.hol-nonproj.csv", 8)



