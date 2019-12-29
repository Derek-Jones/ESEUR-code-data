#
# ase2016-libc.R, 28 Dec 19
# Data from:
# {APEx}: {Automated} Inference of Error Specifications for {C} {APIs}
# Yuan Kang and Baishakhi Ray and Suman Jana
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG statement_mistake error_path statements_number-executed

source("ESEUR_config.r")


library("plyr")


# plot_layout(2, 1, default_width=ESEUR_max_width)
plot_layout(2, 1)

pal_col=rainbow(2)


TF_len=function(df)
{
data.frame(T_len=mean(subset(df, correct == "True")$length),
           F_len=mean(subset(df, correct == "False")$length))
}

# function,site,correct,length
libc=read.csv(paste0(ESEUR_dir, "reliability/ase2016-libc.csv.xz"), as.is=TRUE)

err_len=ddply(libc, .(site), TF_len)

plot(err_len$T_len, err_len$F_len, log="xy", col=point_col,
	xlim=c(2, 500), ylim=c(2, 500),
	xlab="Non-error path statement length", ylab="Error-path statement length\n")

lines(c(1, 1e3), c(1, 1e3), col="grey")

T_len=subset(err_len, !is.na(T_len))$T_len
F_len=subset(err_len, !is.na(F_len))$F_len

plot(density(F_len, from=1), main="", col=pal_col[1],
	xaxs="i", yaxs="i",
	xlim=c(1, 200),
	xlab="Statements", ylab="Density\n")
lines(density(T_len, from=1), col=pal_col[2])

legend(x="topright", legend=c("Error", "Non-error"), bty="n", fill=pal_col, cex=1.2)

