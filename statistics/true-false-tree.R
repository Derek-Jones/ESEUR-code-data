#
# true-false-tree.R,  6 Sep 18
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example


source("ESEUR_config.r")


library("diagram")

plot_discovery=function(power, pvalue, prevalence)
{
num_tests=10000

names=c(
 "10,000\nsample size",
 paste0(num_tests*prevalence/100, "\nhave condition"),
 paste0(num_tests*(100-prevalence)/100, "\ndo not have\ncondition"),
 paste0("detected\n", power*num_tests*prevalence/10000, " True positives"),
 paste0("not detected\n", (100-power)*num_tests*prevalence/10000, " False negatives"),
 paste0("test negative\n",  (100-pvalue)*(100-prevalence)*num_tests/10000, " True negatives"),
 paste0("test positive\n",  pvalue*(100-prevalence)*num_tests/10000, " False positives")
 ) 

M=matrix(data=0, nrow=length(names), ncol=length(names))
colnames(M)=names
rownames(M)=names

tcol=rep("black", nrow(M))
tcol[4]="blue"
tcol[5]="red"
tcol[6]="blue"
tcol[7]="red"

M[names[1], names[2]]=paste0(prevalence, "%")
M[names[1], names[3]]=paste0(100-prevalence, "%")
M[names[2], names[4]]=paste0(power, "%")
M[names[2], names[5]]=paste0(100-power, "%")
M[names[3], names[6]]=paste0(100-pvalue, "%")
M[names[3], names[7]]=paste0(pvalue, "%")

plotmat(t(M), pos=node_layout, lwd=0.8, lcol=point_col,
	curve=0, arr.pos=0.6, arr.length=0.2,
	latex=TRUE,
        box.type="rect", box.prop=0.5, box.size=0.08, box.lcol="white",
	txt.col=tcol,
	shadow.size=0)
}


node_layout=matrix(c(0.1, 0.5, 0.5, 0.9, 0.9, 0.9, 0.9,
		     5/9, 3/9, 7/9, 2/9, 4/9, 6/9, 8/9), ncol=2)


par(mfcol=c(3,1))

par(oma=c(1, 2, 1, 1))
par(mar=c(1, 2, 1, 1))

plot_discovery(80, 5, 1)
plot_discovery(80, 5, 50)
plot_discovery(80, 5, 99)


