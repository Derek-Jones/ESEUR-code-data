#
# fuzzer.R, 20 Sep 20
#
# Data from:
# Comparative Language Fuzz Testing: Programming Languages vs. Fat Fingers
# Diomidis Spinellis and Vassilios Karakoidas and Panos Louridas
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG testing_compile testing_execute testing_output

source("ESEUR_config.r")


library("plyr")


fuzz=read.csv(paste0(ESEUR_dir, "reliability/fuzzer/fuzzer.csv.xz"), as.is=TRUE)


cnt_status=function(df)
{
max_len=nrow(df)
comp=length(which(df$comp_status == "OK"))/max_len
run=length(which(df$run_status == "OK"))/max_len
out=length(which(df$out_status == "OK"))/max_len

return(data.frame(comp, run, out))
}


f_status=ddply(fuzz, .(language), cnt_status)
f_status=f_status[order(f_status$comp, decreasing=TRUE), ]

pal_col=rainbow(nrow(f_status))

barplot(as.matrix(f_status[, 2:4]), col=pal_col, beside=TRUE,
		names=c("Compiled", "Executed", "Output correct"))

legend(x="topright", legend=f_status$language, bty="n", fill=pal_col, cex=1.3)

