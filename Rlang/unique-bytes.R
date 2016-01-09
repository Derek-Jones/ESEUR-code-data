#
# unique-bytes.R,  7 Jan 16
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


window_width=256 # if this is less than 256 divisor has to change in call to plot
 
plot_unique=function(filename)
{
t=readBin(filename, what="raw", n=1e7)
 
# Sliding the window over every point is too much overhead
cnt_points=seq(1, length(t)-window_width, 5)
 
u=sapply(cnt_points, function(X) length(unique(t[X:(X+window_width)])))
plot(u/256, type="l", xlab="File offset", ylab="Fraction Unique\n", las=1)
 
return(u)
}
 
dummy=plot_unique(paste0(ESEUR_dir, "Rlang/unique-bytes.pdf"))

# dummy=plot_unique("http://shape-of-code.coding-guidelines.com/2013/05/17/preferential-attachment-applied-to-frequency-of-accessing-a-variable/")
#  
# dummy=plot_unique("http://www.coding-guidelines.com/R_code/requirements.tgz")

