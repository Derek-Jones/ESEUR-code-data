#
# params.R  1 Jul 14
#
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

col_tab=rainbow(8)

plot_pos=function(np, prog_str)
{
par(col="black")
plot(100*length(np[np == "1_1"])/length(np[np == 1]),
		 xlim=c(1, 8), ylim=c(0, 30), xlab=prog_str, ylab="Percentage")
for (i in 2:8)
   {
   unused=seq(1:i)
   for (j in seq(1:i))
     unused[j]=length(np[np == paste(i, "_", j, sep="")])/length(np[np == i])
   par(new=TRUE)
   plot(100*unused, type="l", col=col_tab[i],
	xlim=c(1, 8), ylim=c(0, 30), xlab="", ylab="")
   }
}


par(mfcol=c(3,3))
par(mai=c(0.6, 0.5, 0.1, 0.2))

net_p=read.csv(paste0(ESEUR_dir, "src_measure/unusedparam/net.params"),
				sep=" ", head=FALSE, as.is=TRUE)
total_unused=net_p[,1]
plot_pos(net_p[,1], "Netscape")
net_p=read.csv(paste0(ESEUR_dir, "src_measure/unusedparam/gcc.params"),
				sep=" ", head=FALSE, as.is=TRUE)
total_unused=append(total_unused, net_p[,1])
plot_pos(net_p[,1], "gcc 2.95")
net_p=read.csv(paste0(ESEUR_dir, "src_measure/unusedparam/linux.params"),
				sep=" ", head=FALSE, as.is=TRUE)
total_unused=append(total_unused, net_p[,1])
plot_pos(net_p[,1], "Linux 2.4.20")
net_p=read.csv(paste0(ESEUR_dir, "src_measure/unusedparam/post.params"),
				sep=" ", head=FALSE, as.is=TRUE)
total_unused=append(total_unused, net_p[,1])
plot_pos(net_p[,1], "Postgresql")
net_p=read.csv(paste0(ESEUR_dir, "src_measure/unusedparam/id.params"),
				sep=" ", head=FALSE, as.is=TRUE)
total_unused=append(total_unused, net_p[,1])
plot_pos(net_p[,1], "id software")
net_p=read.csv(paste0(ESEUR_dir, "src_measure/unusedparam/afs.params"),
				sep=" ", head=FALSE, as.is=TRUE)
total_unused=append(total_unused, net_p[,1])
plot_pos(net_p[,1], "open AFS")
net_p=read.csv(paste0(ESEUR_dir, "src_measure/unusedparam/brl.params"),
				sep=" ", head=FALSE, as.is=TRUE)
total_unused=append(total_unused, net_p[,1])
plot_pos(net_p[,1], "BRL")
net_p=read.csv(paste0(ESEUR_dir, "src_measure/unusedparam/cin.params"),
				sep=" ", head=FALSE, as.is=TRUE)
total_unused=append(total_unused, net_p[,1])
plot_pos(net_p[,1], "Cinelerra")

plot_pos(total_unused, "All programs")

