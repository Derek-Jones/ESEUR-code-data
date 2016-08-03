#
# 19820013026-trend.R, 15 Jul 16
#
# Data from:
# Software Reliability: Repetitive Run Experimentation and Modeling
# Phyllis M. Nagel and James A. Skrivan
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

library("plyr")

plot_layout(2, 1)

rshift_2cols=function(df, col_num)
{
# Copy the case count and leave the err as NA
if (length(col_num) > 0)
   {
   df[ , (col_num+1):(ncol(df)-1)]=df[ , (col_num-1):(ncol(df)-3)]
   df[ , col_num+2]=NA
   }

return(df)
}

# An error of 2_3 means that both faults occurred for the same fault.
# Shift up the counts to adjust for this.
pad_col=function(df)
{
t=grep("_", df)

return(rshift_2cols(df, t))
}


# Get the number of input cases associated with a given error
err_cases=function(df, err_cnt)
{
t_df=subset(df, select=grepl("err", colnames(df)))
t=grep(err_cnt, t_df)

if (length(t) == 0)
   return(NULL)

return(df[ , t*2-1])
}


# Plot the cases executed for every run for a particular error
plot_run_cases=function(err_cnt)
{
t=adply(A2, 1, function(df) err_cases(df, err_cnt))

points(sort(t$V1), col=pal_col[err_cnt-1])
}


A2=read.csv(paste0(ESEUR_dir, "faults/19820013026A2.csv.xz"), as.is=TRUE)

pal_col=rainbow(4)

plot(1, log="y", type="n",
	xaxt="n",
	xlim=c(1, 50), ylim=c(1, 33000),
	xlab="Sorted order", ylab="Number input cases\n")
plot_run_cases(2)
plot_run_cases(3)
plot_run_cases(4)
plot_run_cases(5)



# t=adply(A2, 1, pad_col)
t=A2
pal_col=rainbow_hcl(nrow(t))

cases=subset(t, select=grepl("case", colnames(t)))

plot(1, log="y", type="n",
		xlim=c(1, 6), ylim=c(1, 33000),
		xlab="Faults experienced", ylab="Number of input cases\n")

dummy=sapply(1:nrow(cases), function(X) lines(t(cases[X, ]), col=pal_col[X]))


