#
# 1998_005_001_16640.R, 24 Feb 17
# Data from:
# Hughes Aircraft's} Widespread Deployment of a Continuously Improving Software Process
# Ron R. Willis and Robert M. Rova and Mike D. Scott and Martha I. Johnson and John F. Ryskowski and Jane A. Moon and Ken C. Shumate and Thomas O. Winfield
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(7)


floc=read.csv(paste0(ESEUR_dir, "economics/1998_005_001_16640.csv.xz"), as.is=TRUE)

b91=subset(floc, Before.91 == 1)
b91=b91[-10, ] # Last row contains the average

plot(b91$SRS_IRS, type="l", col=pal_col[1],
	xaxt="n",
	ylim=c(0, 4),
	xlab="", ylab="Effort per fault (days)")

x_at=1:length(b91$Phase)
# axis(side=1, at=x_at, labels=b91$Phase, las=2)
axis(1, at=x_at, labels=FALSE)
text(x=x_at+0.3, y=par()$usr[3]-0.03*(par()$usr[4]-par()$usr[3]),
                labels=b91$Phase, pos=2, srt=30, cex=1.1)

col_num=1
lines(b91$Prelim.Design, col=pal_col[2])
lines(b91$Detailed.Design, col=pal_col[3])
lines(b91$Code, col=pal_col[4])
lines(b91$Unit.Test.Procs, col=pal_col[5])
lines(b91$Int.Test.Procs, col=pal_col[6])
lines(b91$Other.Del, col=pal_col[7])

legend(x="topleft", legend=c("SRS/IRS", "Preliminary design", "Detailed Design", "Code", "Unit test procedures", "Integration test procedures", "Other"), bty="n", fill=pal_col, cex=1.2)


# library(limSolve)
# 
# 
# ratios=b91[1:9, 3:9]
# sr=ratios[!is.na(ratios)]
# num_ratios=length(sr)
# 
# # simeq=matrix(data=0, nrow=num_ratios+7+9, ncol=2*num_ratios)
# zeroes=rep(0, num_ratios+7)
# simeq=matrix(data=0, nrow=num_ratios+7, ncol=2*num_ratios)
# 
# simeq[cbind(1:num_ratios, 2*(1:num_ratios))]=-sr
# simeq[cbind(1:num_ratios, 2*(1:num_ratios)-1)]=1
# 
# # One column has an NA within the sequence of values...
# a_off=0
# for (r in 1:7)
#    {
#    col_len=length(which(!is.na(ratios[, r])))
#    simeq[num_ratios+r, 2*(a_off+(1:col_len))]=-b91[10, r+2]
#    simeq[num_ratios+r, 2*(a_off+(1:col_len))-1]=1
#    a_off=a_off+col_len
#    }
# 
# # Also need to handle column averages...
# 
# # Since the rhs is all zero, all zeroes is the optimal least squares solution
# # sol=Solve(simeq, zeroes)
# 
# sol=xsample(E=simeq, F=zeroes)
# 
