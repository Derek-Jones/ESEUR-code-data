#
# RTdistPalmer.R, 27 Aug 20
# Data from:
# What Are the Shapes of Response Time Distributions in Visual Search?
# Evan M. Palmer and Todd S. Horowitz and Antonio Torralba and Jeremy M. Wolfe
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human visual_search

source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(3)


plot_condition=function(df)
{
   subj_mean=function(df, line_lty, pt_pch)
   {
   col_str=df$col_str[1]
   smean=ddply(df, .(Setsize, Subject), function(df) mean(df$RT))
   points(jitter(smean$Setsize), smean$V1, col=col_str, pch=pt_pch)
   ps_mod=glm(RT ~ Setsize, data=df)
   pred=predict(ps_mod, newdata=data.frame(Setsize=x_bounds))
   lines(x_bounds, pred, col=col_str, lty=line_lty)
   }

x_bounds=unique(df$Setsize)

present=subset(df, Targ_Pres == 1)
missing=subset(df, Targ_Pres == 0)

subj_mean(present, 1, "+")
subj_mean(missing, 2, "o")
}


rt=read.csv(paste0(ESEUR_dir, "developers/RTdistPalmer.csv.xz"), as.is=TRUE)

# Filter responses that are too fast or slow
rt=subset(rt, (RT > 200) & (RT < 4000))
rt$RT=rt$RT/1e3

u_condition=unique(rt$Condition)

x_bounds=unique(rt$Setsize)
rt$col_str=mapvalues(rt$Condition, u_condition, pal_col[1:3])

plot(1, type="n",
	xlim=range(rt$Setsize), ylim=c(0.3, 2.4),
	xlab="Number of items", ylab="Response time (secs)\n")
legend(x="topleft", legend=u_condition, bty="n", fill=pal_col, cex=1.2)

d_ply(rt, .(Condition), plot_condition)

