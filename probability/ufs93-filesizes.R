#
# ufs93-filesizes.R, 6 Jan 16
#
# Data from:
#
# Unix File Size Survey - 1993
# Gordon Irlam
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


pal_col=rainbow(3)

# max_file_size,num_files,perc_files,cum_perc_files,disk_space,perc_space,sum_perc_space
ufs93=read.csv(paste0(ESEUR_dir, "probability/ufs93-filesizes.csv.xz"), as.is=TRUE)

cum_files=cumsum(ufs93$perc_files)/100
cum_disk_space=cumsum(ufs93$perc_space)/100

plot(ufs93$max_file_size, cum_files, type="l", log="x", col=pal_col[1],
	ylim=c(0, 1),
	xaxt="n",
	xlab="Total size (bytes)", ylab="Cumulative probability\n")
axis(1, at=c(16, 512, 16e3, 512e3, 16e6, 512e6),
        labels=c("16", "512", "16K", "512K", "16M", "512M"))
text(100, 0.2, "files", cex=1.4)

lines(ufs93$max_file_size, cum_disk_space, col=pal_col[3])
text(200e3, 0.2, "bytes", cex=1.4)

# Numbers are approximate, worked out by hand.
lines(c(15.6e3, 15.6e3), c(cum_disk_space[16], cum_files[16]), col=pal_col[2])

