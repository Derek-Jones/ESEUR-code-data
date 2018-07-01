#
# method-usage.R, 12 Jun 18
#
# Data from:
# Empirical Evidence of Large-Scale Diversity in {API} Usage of Object-Oriented Software
# Diego Mendez and Benoit Baudry and Martin Monperrus
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG string call-sequence source-usage Java


source("ESEUR_config.r")


library("diagram")

plot_wide()

# method-seq,uses,num-methods
# append,353547,1
sb=read.csv(paste0(ESEUR_dir, "sourcecode/api-usage/StringBuilder.csv.xz"), as.is=TRUE)

names=paste0(sb$method_seq[1:10], "\n", sb$uses[1:10])
names=names[order(sb$num_methods[1:10])]

M=matrix(data=0, nrow=length(names), ncol=length(names))
colnames(M)=names
rownames(M)=names

M[names[1], names[4]]=""
M[names[1], names[6]]=""
M[names[2], names[5]]=""
M[names[2], names[6]]=""
M[names[2], names[7]]=""
M[names[3], names[4]]=""
M[names[3], names[5]]=""
M[names[3], names[6]]=""
M[names[4], names[8]]=""
M[names[6], names[8]]=""
M[names[7], names[8]]=""
M[names[8], names[9]]=""
M[names[8], names[10]]=""

plotmat(t(M), pos=c(3, 4, 1, 2), lwd=1, curve=0, cex=1.4,
	arr.type="triangle", arr.pos=0.63, endhead=TRUE, arr.width=0.15,
	arr.length=0.15, arr.lcol="grey", cex.txt=1.0,
        box.type="ellipse", box.prop=0.5, box.lcol="white", box.cex=1.6,
	txt.col=point_col, shadow.size=0)

