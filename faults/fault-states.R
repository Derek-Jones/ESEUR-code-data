#
# fault-states.R, 20 Jan 15
#
# Data from:
# Software Reliability: Repetitive Run Experimentation and Modeling
# Phyllis M. Nagel and James A. Skrivan
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("diagram")


names=c("A2-0",
	"1", "2",
	"13", "12", "14",
	"123", "124", "125", "134",
	"1235", "1234",
	"12345")

M=matrix(data=0, nrow=length(names), ncol=length(names))
colnames(M)=names
rownames(M)=names

# Figure 4.4.7.1-1. Trace of Runs for Subject Program A2.
# 
M["A2-0", "1"]=37
M["A2-0", "2"]=2
M["A2-0", "12"]=10
M["A2-0", "14"]=1
M["1", "13"]=1
M["1", "124"]=1
M["1", "12"]=34
M["1", "14"]=1
M["2", "12"]=2
M["13", "123"]=1
M["12", "123"]=17
M["12", "124"]=28
M["12", "125"]=1
M["12", "124"]=28
M["12", "134"]=1
M["14", "124"]=1
M["14", "134"]=1
M["123", "1235"]=1
M["123", "1234"]=17
M["124", "1234"]=30
M["134", "1234"]=1
M["1234", "12345"]=22

plotmat(t(M), pos=c(1, 2, 3, 4, 2, 1), lwd=1, arr.pos=0.4,
	 box.type="rect", box.prop=0.5, box.size=0.05, shadow.size=0)

