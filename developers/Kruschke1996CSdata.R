#
# Kruschke1996CSdata.R, 11 Jan 19
# Data from:
# John K. Kruschke
# Dimensional Relevance Shifts in Category Learning
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment subject learning

source("ESEUR_config.r")

pal_col=rainbow(4)


# Each row has data from a single trial.
# The fields of each row are as follows:
# 1. shift group (1-4)
#   group 1 = reversal shift,
#   group 2 = relevant shift,
#   group 3 = irrelevant shift,
#   group 4 = compound shift.
# 2. subject number (arbitrary id; 240 subjects total)
# 3. trial (9-264; first 8 trials were mere exposure trials)
# 4. pattern number (1-8)
# 5. response accuracy (0=wrong, 1=correct, 2=no response)
# 6. response selction (1,2=possible, 0=no response)
# 7. response time in msec

ks=read.csv(paste0(ESEUR_dir, "developers/Kruschke1996CSdata.csv.xz"), as.is=TRUE)

mean_correct=function(df)
{
correct=ddply(df, .(trial), function(df_tr)
				 length(which(df_tr$resp_acc==1))/
					length(which(df_tr$resp_acc!=2)))
return(correct)
}


draw_correct=function(df, col_str)
{
# The paper averages over blocks of eight, not a running average
epoch=sapply(0:31, function(X) mean(df$V1[X*8+1:8]))
lines(1:32, epoch, col=col_str)
}



sg_1=subset(ks, shift_group == 1)
sg_2=subset(ks, shift_group == 2)
sg_3=subset(ks, shift_group == 3)
sg_4=subset(ks, shift_group == 4)

plot(0, type="n",
	xlim=c(1, 32), ylim=c(0.45, 1),
	xlab="Block", ylab="Probability correct\n")

cc_1=mean_correct(sg_1)
draw_correct(cc_1, pal_col[1])
cc_2=mean_correct(sg_2)
draw_correct(cc_2, pal_col[2])
cc_3=mean_correct(sg_3)
draw_correct(cc_3, pal_col[3])
cc_4=mean_correct(sg_4)
draw_correct(cc_4, pal_col[4])


legend(x="bottom", legend=c("Reversal", "1-characteristic", "2-characteristics", "3-characteristics"),
			bty="n", fill=pal_col, cex=1.2)
 
