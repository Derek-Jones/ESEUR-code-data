#
# filesystem-SSD.R, 13 Oct 17
#
# Data from:
# An Empirical Study on the Interplay Between Filesystems and SSD
# Ke Zhou and Ping Huang and Chunhua Li and Hua Wang
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


file_ssd=read.csv(paste0(ESEUR_dir, "benchmark/20120915-figures.csv.xz"), as.is=TRUE)

brew_col=rainbow(4)

plot_option=function(df, col_num, f_str)
{
num_row=nrow(df)

lines(offset:(offset+num_row-1), df$nops, type="b", col=brew_col[col_num])
mtext(f_str, 1, at=offset+num_row/2-0.5, padj=-1, cex=0.8)
offset <<- offset+num_row
}

offset=1
plot(1, type="n", bty="n",
	xaxt="n",
	xlim=c(1, 32), ylim=c(0, 2000),
	xlab="Filesystem", ylab="Operations per second\n")
plot_option(subset(file_ssd, filesystem=="e2"), 1, "ext2")
plot_option(subset(file_ssd, filesystem=="e3"), 2, "ext3")
plot_option(subset(file_ssd, filesystem=="rfs"), 3, "rfs")
plot_option(subset(file_ssd, filesystem=="xfs"), 4, "xfs")


# common_option=subset(file_ssd, option %in% c("blk1k", "blk2k", "noatime", "none"))
# 
# n_mod=glm(nops ~ filesystem + option, family=quasipoisson, data=file_ssd)
#
# n_mod=glm(nops ~ option, family=quasipoisson, data=common_option)


