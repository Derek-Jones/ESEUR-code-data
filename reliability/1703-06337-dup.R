#
# 1703-06337-dup.R, 13 Nov 19
# Data from:
# Rediscovery Datasets: Connecting Duplicate Reports
# Mefta Sadat and Ayse Basar Bener and Andriy V. Miranskyy
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG fault-report_duplicate


source("ESEUR_config.r")


library("diagram")


pal_col=rainbow(2)

rep_pos=coordinates(c(3, 1, 3, 4, 2, 2))

# Nodes appear left to right, starting top left, finish bottom right
names=as.character(c(5544, 6136, 13724, 6325, 4760, 25256, 31201,
		16783, 18247, 19760, 4671,
		19128, 19274, 23194, 23196))

M=matrix(data=0, nrow=length(names), ncol=length(names))
colnames(M)=names
rownames(M)=names

M["6325", "5544"]=""; M["6325", "6136"]=""; M["6325", "13724"]=""

M["6325", "4760"]=""; M["6325", "25256"]=""; M["6325", "31201"]=""

M["4760", "16783"]=""; M["4760", "18247"]=""; M["4760", "19760"]="";
M["25256", "4671"]=""

M["19760", "19274"]=""; M["19760", "19128"]=""

M["19274", "23194"]=""; M["19274", "23196"]=""

plotmat(t(M), pos=rep_pos, lwd=1,
	arr.lcol=pal_col[2], arr.pos=0.6, arr.length=0.15, cex=1.2,
        box.lcol="white", box.prop=0.5, box.size=0.05, box.cex=1.2,
	txt.col=pal_col[1], shadow.size=0)

