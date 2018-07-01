#
# namedparam.R, 23 Apr 14
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


col_tab=rainbow(8)

unused_p=read.csv(paste0(ESEUR_dir, "src_measure/unusedparam/unused.names"), as.is=TRUE)

plot_pos=function(prog_str)
{
par(col="black")
plot(unused_p[1, 4],
		 xlim=c(1, 8), ylim=c(60, 100), xlab=prog_str, ylab="Percentage")
offset=1
for (i in 2:8)
   {
   offset=offset+i-1
   perc=unused_p[1:i+(offset-1), 4]
   par(new=TRUE)
   plot(perc, type="l", col=col_tab[i],
	xlim=c(1, 8), ylim=c(60, 100), xlab="", ylab="")
   }
}

plot_pos("Parameter")

