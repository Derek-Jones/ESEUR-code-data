#
# filesystem-SSD.R,  2 Dec 15
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

brew_col=rainbow_hcl(4)

plot_option=function(df, col_num)
{
num_row=nrow(df)
par(new=TRUE)
plot(offset:(offset+num_row-1), df$nops, type="h", col=brew_col[col_num],
	xaxt="n", yaxt="n",
	xlab="", ylab="",
	xlim=c(1, 32), ylim=c(0, 2000))
points(offset:(offset+num_row-1), df$nops)
offset <<- offset+num_row
}

par(bty="n")
offset=1
plot(1, type="n",
	xaxt="n", xlab="", ylab="Operations per second\n",
	xlim=c(1, 32), ylim=c(0, 2000))
plot_option(subset(file_ssd, filesystem=="e2"), 1)
plot_option(subset(file_ssd, filesystem=="e3"), 2)
plot_option(subset(file_ssd, filesystem=="rfs"), 3)
plot_option(subset(file_ssd, filesystem=="xfs"), 4)


# common_option=subset(file_ssd, option %in% c("blk1k", "blk2k", "noatime", "none"))
# 
# n_mod=glm(nops ~ filesystem + option, family=quasipoisson, data=file_ssd)
#
# n_mod=glm(nops ~ option, family=quasipoisson, data=common_option)


