#
# 200xdisks.R, 30 Dec 15
#
# Data from:
# Disks are like snowflakes: No two are alike
# Elie Krevat and Joseph Tucek and Gregory R. Ganger
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("plyr")

brew_col=rainbow_hcl(12)

plot_disk=function(df)
{
points(df$offset, df$bandwidth, col=brew_col[df$disk])
}


plot_layout(1, 2)

disk2002=read.csv(paste0(ESEUR_dir, "benchmark/2002disks.csv.xz"), as.is=TRUE)

# Convert to Gigabtyes
disk2002$offset=disk2002$offset / 1000
disk2002$disk=as.factor(disk2002$disk)

bw_range=range(disk2002$bandwidth)
off_range=range(disk2002$offset)
plot(1, type="n",
	xlim=off_range, ylim=bw_range,
	xlab="Offset (GB)", ylab="Bandwidth (MB sec)\n")

d_ply(disk2002, .(disk), plot_disk)


# d2_mod=glm(bandwidth ~ offset+disk+trial, data=disk2002)

disk2006=read.csv(paste0(ESEUR_dir, "benchmark/2006disks.csv.xz"), as.is=TRUE)
disk2006$offset=disk2006$offset / 1000

disk2006=subset(disk2006, sd_id == "sda")
disk2006$disk=as.factor(disk2006$disk)

bw_range=range(disk2006$bandwidth)
off_range=range(disk2006$offset)
plot(1, type="n",
	xlim=off_range, ylim=bw_range,
	xlab="Offset (GB)", ylab="Bandwidth (MB sec)\n")

d_ply(disk2006, .(disk), plot_disk)

# d6_mod=glm(bandwidth ~ offset+disk+trial, data=disk2006)

# summary(d6_mod)


# disk2008=read.csv(paste0(ESEUR_dir, "benchmark/2008disks.csv.xz"), as.is=TRUE)
# disk2008$offset=disk2008$offset / 1000

# Remove 'noise' trial
# disk2008=subset(disk2008, trial != 2)

# disk2008=subset(disk2008, grepl("1u", disk))
#disk2008=subset(disk2008, !(disk %in% c("cirrus2u21", "cirrus2u25", "cirrus2u26")))

# disk2008$disk=as.factor(disk2008$disk)

# bw_range=range(disk2008$bandwidth)
# d_ply(disk2008, .(disk), plot_disk)

# d8_mod=glm(bandwidth ~ offset*disk, data=disk2008, subset=(trial != 2))

# summary(d7_mod)

