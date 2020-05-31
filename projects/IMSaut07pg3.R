#
# IMSaut07pg3.R, 23 May 20
# Data from:
# Understanding the Sources of Information Systems Project Failure: {A} study in {IS} project failure
# John McManus and Trevor Wood-Harper
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG project_cancelled project_overrun

source("ESEUR_config.r")


library("survival")


par(mar=MAR_default+c(1.3, 0.0, 0, 0))


IM=read.csv(paste0(ESEUR_dir, "projects/IMSaut07pg3.csv.xz"), as.is=TRUE)

Handover=7

# Projects are censored at handover
IM$Cancelled[Handover]=IM$Completed[Handover]

IM_age=rep(1:Handover, times=IM$Cancelled)

proj_surv=Surv(IM_age, event=(IM_age != Handover))
p_mod=survfit(proj_surv ~ 1)

plot(p_mod, col=pal_col[c(1, 2, 2)],
	xaxt="n",
        xaxs="i", yaxs="i",
        ylim=c(0.65, 1),
        ylab="Project survival\n")

x_at=1:7
axis(1, at=x_at, labels=FALSE)
text(x=x_at+0.3, y=par()$usr[3]-0.03*(par()$usr[4]-par()$usr[3]),
                labels=IM$Lifecycle.stage, pos=2, srt=20, cex=1.2, xpd=TRUE)

