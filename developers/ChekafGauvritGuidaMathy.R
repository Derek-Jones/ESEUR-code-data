#
# ChekafGauvritGuidaMathy.R, 13 Dec 19
# Data from:
# Compression in Working Memory and its Relationship with Fluid Intelligence
# Mustapha Chekaf and Nicolas Gauvrit and Alessandro Guida and Fabien Mathy
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human memory_short-term information_compression

source("ESEUR_config.r")


library("betareg")
library("plyr")
library("stringdist")


pal_col=rainbow(3)


# Fraction correct and fraction of errors
per_color=function(df)
{
t=ddply(df, .(lengthList), function(df)
				data.frame(p_cor=sum(df$correct)/nrow(df),
					   p_err=sum(df$osa/df$lengthList)/nrow(df)))
return(t)
}


# subject name <500 = Exp1 Simon visuo-spatial (non central)
# subject name >500 = Exp2 Simon central
# ageMonths : âge in months
# lengthList : list length 
# nColors : number of possible colours in list 
# nChunks : number of chunks (1 chunk = group of repeated items or 1 isolated item) (only consecutive items were considered)
# list :  content of a to-be-memorized sequence, 4 digits, each digit represents a colour
# response :  response , 4 digits, one by colour
# globalRT: global response time 
# correct :  raw score: 1 if correct; 0 if not correct
# NcorrectAlign :  number of items corrects aligned compared to the original list 
# APM : Raven sore
# kListBrut :  complexity of the presented list
# kResponseBrut :  complexity of the response
# kList : complexity of the original list 
# kResponse : complexity of the response
# OSMean: WMCT substest (Working Memory capacity Battery)
# OSptMean: WMCT substest (Working Memory capacity Battery)
# SSMean: WMCT substest (Working Memory capacity Battery) 
# SSptMean: WMCT substest (Working Memory capacity Battery)
# SSTMMean: WMCT substest (Working Memory capacity Battery)
# wmbMean : composite score obtained for the whole working memory capacity battery  (mean score for OSMean, OSptMean, SSMean, SSptMean and SSTMMean)
# propCorrectAlign : proportion of correctly aligned items (=nCorrectAlign / lengthList)
# propCorrectAlign_mean : mean of propCorrectAlign agregated by participant
# Span : scoring for each participant: 
#                         Span = correct * frequency 
#                         with frequency = number of list by sequence length, exple there are 6 possible lists (sequences) for list length=4, frequency=1/6; 
# 
chek=read.csv(paste0(ESEUR_dir, "developers/ChekafGauvritGuidaMathy.csv.xz"), as.is=TRUE)

# What is the edit distance between actual and response?
# Optimal String Alignment, distance calculated using
# insertion, deletion, substitution and transposition
# chek$osa=stringdist(chek$list, chek$response, method="osa")
# 
# 
# plot(chek$kList, chek$kResponse)
# 
# lines(c(0, 40), c(0, 40), col="green")
# 
# # r_mod=glm(kResponse ~ kList+I(kList^2), data=chek)
# r_mod=glm(log(kResponse) ~ log(kList), data=chek) # the better fit
# summary(r_mod)
# 
# pred=predict(r_mod, newdata=data.frame(kList=1:40))
# lines(pred, col="red")


# Get fraction correct for each color and sequence length
col_len=ddply(chek, .(nColors), per_color)

col_len=subset(col_len, nColors != 1)

plot(0, type="n",
	yaxs="i",
	xlim=c(2, 10), ylim=c(0, 1),
	xlab="Sequence length", ylab="Proportion correct\n")
d_ply(col_len, .(nColors), function(df) points(df$lengthList, df$p_cor, col=pal_col[df$nColors[1]-1]))

legend(x="topright", legend=c("Two colors", "Three colors", "Four colors"), bty="n", fill=pal_col, cex=1.2)

# An almost perfect fit
cl_mod=betareg(p_cor ~ nColors*lengthList, data=col_len)
summary(cl_mod)

pred_2=predict(cl_mod, newdata=data.frame(nColors=2, lengthList=2:10))
lines(2:10, pred_2, col=pal_col[1])
pred_3=predict(cl_mod, newdata=data.frame(nColors=3, lengthList=2:10))
lines(2:10, pred_3, col=pal_col[2])
pred_4=predict(cl_mod, newdata=data.frame(nColors=4, lengthList=2:10))
lines(2:10, pred_4, col=pal_col[3])

# # Another almost perfect fit
# col_len$p_err=col_len$p_err+1e-6
# err_mod=betareg(p_err ~ nColors*lengthList, data=col_len)
# summary(err_mod)
# 
# plot(0, type="n",
# 	yaxs="i",
# 	xlim=c(1, 10), ylim=c(0, 1),
# 	xlab="Sequence length", ylab="Incorrect items (fraction)\n")
# d_ply(col_len, .(nColors), function(df) points(df$lengthList, df$p_err, col=pal_col[df$nColors[1]]))
# 
# 
# # How good a fit is the complexity measure?
# plot(0, type="n",
# 	yaxs="i",
# 	xlim=c(4, 36), ylim=c(0, 1),
# 	xlab="Complexity", ylab="Proportion correct\n")
# 
# comp_cor=ddply(chek, .(kList), function(df) sum(df$correct)/nrow(df))
# 
# comp_cor=subset(comp_cor, p_cor != 0)
# comp_cor$p_cor=comp_cor$p_cor-1e-5
# 
# # Good, but not as good as color+length
# cc_mod=betareg(p_cor ~ kList, data=comp_cor)
# summary(cc_mod)
# 
# pred=predict(cc_mod)
# lines(comp_cor$kList, pred)
# 
# # How well can kList be modeled using color and length?
# 
# kl_mod=glm(kList ~ (nColors+lengthList)^2, data=chek)
# summary(kl_mod)
# 
# 
