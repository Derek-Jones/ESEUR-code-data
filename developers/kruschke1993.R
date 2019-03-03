#
# kruschke1993.R, 11 Jan 19
# Data from:
# John K. Kruschke
# Human Category Learning: {Implications} for Backpropagation Models
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment subject learning

source("ESEUR_config.r")


library("plyr")

pal_col=rainbow(4)


# The stimuli were rectangles that varied in height, with an interior 
# vertical segment that varied in its lateral position.  Best fitting 
# psychological scale values (data from a different experiment; see 
# Kruschke 1993):
# 
#                      ^
#             1.5968   |              6       4             numerical
# height of            |                                    pattern
# rectangle   0.43575  |      8                      2      identifier
#                      |
#            -0.51625  |      7                      1
#                      |
#            -1.5163   |              5       3
#                      +---------------------------------->
#                         -1.5712 -0.51625 0.6588 1.4878
#                                horizontal position
#                                of interior segment
# 
# For categorization condition 1 (filtration),
#   horizontal position was relevant, i.e., 
#   exemplars 1,2,3,4 vs. 5,6,7,8
# For condition 2 (filtration), 
#   height was relevant, i.e.,
#   exemplars 1,3,5,7 vs. 2,4,6,8
# For condition 3 (condensation), 
#   the dividing line was the left diagonal, i.e.,
#   exemplars 1,2,4,6 vs. 3,5,7,8
# For condition 4 (condensation), 
#   the dividing line was the right diagonal, i.e.,
#   exemplars 1,2,3,5 vs. 4,6,7,8
#
# Data format. Each row has the following fields:
# column 1: the categorization condition (1-4, as elaborated above),
# col 3-4: the subject number (1-40 for each condition)
# col 6-7: the trial number (1-64 for each subject)
# col. 9: the pattern identifier (same sequence for every subject, 
#          with pattern numbers as specified above)
# col. 11: response accuracy (0=wrong, 1=correct, 2=no response 
#                             within 30 sec)
# col. 13-17: response time in milliseconds

kr=read.csv(paste0(ESEUR_dir, "developers/kruschke1993.csv.xz"), as.is=TRUE)


mean_correct=function(df)
{
correct=ddply(df, .(trial), function(df_tr)
				 length(which(df_tr$response==1))/
					length(which(df_tr$response!=2)))
return(correct)
}


draw_correct=function(df, col_str)
{
# The paper averages over blocks of eight, not a running average
epoch=sapply(0:7, function(X) mean(df$V1[X*8+1:8]))
lines(1:8, epoch, col=col_str)
}



cond_1=subset(kr, cat_cond == 1)
cond_2=subset(kr, cat_cond == 2)
cond_3=subset(kr, cat_cond == 3)
cond_4=subset(kr, cat_cond == 4)

plot(0, type="n",
	xlim=c(1, 8), ylim=c(0.45, 1),
	xlab="Block", ylab="Probability correct\n")

cc_1=mean_correct(cond_1)
draw_correct(cc_1, pal_col[1])
cc_2=mean_correct(cond_2)
draw_correct(cc_2, pal_col[2])
cc_3=mean_correct(cond_3)
draw_correct(cc_3, pal_col[3])
cc_4=mean_correct(cond_4)
draw_correct(cc_4, pal_col[4])


legend(x="bottomright", legend=c("Position", "Height",
				"Position/height", "Position/height"),
			bty="n", fill=pal_col, cex=1.2)
 
