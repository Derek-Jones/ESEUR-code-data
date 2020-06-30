#
# 3356579a.R,  7 Jun 20
# Data from:
# How {C++} Templates Are Used for Generic Programming: {An} Empirical Study on 50 Open Source Systems
# Lin Chen and Di Wu and Wanwangying Ma and Yuming Zhou and Baowen Xu and Hareton Leung
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG C++_templates STL_usage


source("ESEUR_config.r")


library(plyr)


cf=read.csv(paste0(ESEUR_dir, "sourcecode/3356579-func.csv.xz"), as.is=TRUE)


plot_ins=function(df)
{
ic=count(df$instantiations)

ic2=subset(ic, freq > 1)

ic2=ic2[order(ic2$freq, decreasing=TRUE),]
ic2$rank=1:nrow(ic2)

points(ic2$freq, col=df$col_str[1])
ins_mod=glm(log(freq) ~ log(rank), data=ic2)

 print(summary(ins_mod))

pred=predict(ins_mod)
lines(exp(pred), col=df$col_str[1])

return(ins_mod)
}


u_str=unique(c("Chromium", "Haiku", cf$project))
pal_col=rainbow(length(u_str))
cf$col_str=mapvalues(cf$project, u_str, pal_col)

plot(1, type="n", log="xy",
	xaxs="i", yaxs="i",
	xlim=c(1, 50), ylim=c(2, 5e3),
	xlab="Function template rank", ylab="Instantiations\n")

d_ply(cf, .(project), plot_ins)

legend(x="topright", legend=u_str, bty="n", fill=pal_col, cex=1.2)

# cc=read.csv(paste0(ESEUR_dir, "sourcecode/3356579-class.csv"), as.is=TRUE)
# 
# u_str=unique(c("Chromium", "Haiku", cc$project))
# pal_col=rainbow(length(u_str))
# cc$col_str=mapvalues(cc$project, u_str, pal_col)
# 
# plot(1, type="n", log="xy",
#         xaxs="i", yaxs="i",
#         xlim=c(1, 50), ylim=c(2, 5e2),
#         xlab="Class template rank", ylab="Instantiations\n")
# 
# d_ply(cc, .(project), plot_ins)
# 
# legend(x="topright", legend=u_str, bty="n", fill=pal_col, cex=1.2)
# 

