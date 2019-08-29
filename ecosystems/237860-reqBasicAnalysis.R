#
# 237860-reqBasicAnalysis.R, 12 Jul 19
# Data from:
# Analysing the evolution of system requirements -- {A} Case Study of {AUTOSAR} at {Volvo} Car Group
# Corrado Motta
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG requirements evolution automotive


source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(3)


count_req=function(df)
{
   sum_col=function(df_col)
   {
   num_add=length(which(df_col == 1))
   num_mod=length(which(df_col == 2))
   num_del=length(which(df_col == 3))
   return(data.frame(num_add, num_mod, num_del))
   }

r4=sum_col(df$r4.0.1)
r4=rbind(r4, sum_col(df$r4.0.2))
r4=rbind(r4, sum_col(df$r4.0.3))
r4=rbind(r4, sum_col(df$r4.1.1))
r4=rbind(r4, sum_col(df$r4.1.2))
r4=rbind(r4, sum_col(df$r4.1.3))
r4=rbind(r4, sum_col(df$r4.2.1))
r4=rbind(r4, sum_col(df$r4.2.2))
return(r4)
}


req=read.csv(paste0(ESEUR_dir, "ecosystems/237860-reqBasicAnalysis.csv.xz"), as.is=TRUE, sep=";")

sws=subset(req, Req_top == "SWS")

sws_cnt=count_req(sws)

plot(cumsum(sws_cnt$num_add), type="b", col=pal_col[1],
	xlim=c(1, 7), ylim=c(400, 9000),
	xaxs="i", xaxt="n",
	xlab="Release", ylab="Requirements\n")
axis(1, at=1:7, label=c("4.0.1", "4.0.2", "4.0.3", "4.1.1", "4.1.2", "4.1.3", "4.2.1"))

lines(cumsum(sws_cnt$num_mod), type="b", col=pal_col[2])
lines(cumsum(sws_cnt$num_del), type="b", col=pal_col[3])

legend(x="topleft", legend=c("Added", "Modified", "Deleted"), bty="n", fill=pal_col, cex=1.2)

# sws_sub=ddply(req, .(Req_sub), count_req)

