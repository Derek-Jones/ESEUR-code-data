#
# 19820013026-trend.R,  25 Dec 19
#
# Data from:
# Software Reliability: Repetitive Run Experimentation and Modeling
# Phyllis M. Nagel and James A. Skrivan
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_software reliability input

source("ESEUR_config.r")


library("plyr")

plot_layout(2, 1)


rshift_2cols=function(df, col_num)
{
if (length(col_num) > 0)
   {
   df[ , (col_num+1):(ncol(df)-1)]=df[ , (col_num-1):(ncol(df)-3)]
   err_list=strsplit(df[ , col_num], "_")
   df[ , col_num]=err_list[[1]][1]
   df[ , col_num+2]=err_list[[1]][2]
   }

return(df)
}

# An error of 2_3 means that both faults occurred for the same input.
# Shift the columns along to adjust for this.
pad_col=function(df)
{
t=grep("_", df)

# Assume there are only ever two faults for the same input case
return(rshift_2cols(df, t))
}

# Unpack errors of the form 2_3, where two faults occurred for the same input.
unpack_err=function(df)
{
t=adply(df, 1, pad_col)
}


fault_exp=function(X)
{
appear_num=which(t(errs[X, ]) == fault_num)
return(cumsum(t(cases[X, ]))[appear_num])
}

plot_fault_num=function(f_num)
{
fault_num <<- f_num
fault_inputs=unlist(sapply(1:nrow(A2), fault_exp))
points(sort(fault_inputs), col=pal_col[fault_num])
}


AB=read.csv(paste0(ESEUR_dir, "reliability/19820013026AB.csv.xz"), as.is=TRUE)
A2=subset(AB, program == "A2")

pal_col=rainbow_hcl(nrow(A2))

A2_un=unpack_err(A2)
A2_un$err1=as.numeric(A2_un$err1)
A2_un$err2=as.numeric(A2_un$err2)
A2_un$err3=as.numeric(A2_un$err3)

cases=subset(A2_un, select=grepl("case", colnames(A2)))
errs=subset(A2_un, select=grepl("err", colnames(A2)))

plot(1, log="x", type="n",
		xlim=c(1.3, 33000), ylim=c(1.1, 5),
		xlab="Inputs processed", ylab="Faults experienced\n")

dummy=sapply(1:nrow(cases), function(X) lines(cumsum(t(cases[X, ])), 1:6, col=pal_col[X]))


pal_col=rainbow(5)

plot(1, log="y", type="n",
	xaxs="i",
	xlim=c(0, 50), ylim=c(1, 33000),
	xlab="Sorted order", ylab="Inputs processed\n")

legend(x="topright", legend=paste0("Fault ", c("a", "b", "c", "d", "e")),
					 bty="n", fill=pal_col, cex=1.2)

# Why is unlist needed?  No idea.

plot_fault_num(1)
plot_fault_num(2)
plot_fault_num(3)
plot_fault_num(4)
plot_fault_num(5)


