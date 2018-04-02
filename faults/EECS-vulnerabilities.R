#
# EECS-vulnerabilities.R, 19 Mar 18
# Data from:
# Towards Evidence-Based Assessment of Factors Contributing to the Introduction and Detection of Software Vulnerabilities
# Matthew Finifter
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


library("plyr")

pal_col=rainbow_hcl(3)


plot_fault_count=function(fault_list, fault_str)
{
t=ddply(fault_list, .(team_number), function(df) {
				t1=table(df$found_using)
				t2=empty_found
				t2[names(t1)]=t1
				return(t2)
				})
rownames(t)=1:9

# Some programs don't have any instance of a particular fault
# Create an empty data frame of the desired size and zero values,
# then fill it up with what we know.
# q=t[1:9,]
# q[,]=0
# q$team_number=1:9
# q[t$team_number, ]=t

barplot(t(as.matrix(t[ , -1])), col=pal_col,
	xlab=fault_str, ylab="Vulnerabilities\n",
	ylim=c(0, 35))
}


EECS=read.csv(paste0(ESEUR_dir, "faults/EECS-vulnerabilities.csv.xz"), as.is=TRUE)

empty_found=NULL
empty_found[unique(EECS$found_using)]=0

plot_fault_count(EECS, "Implementation")

legend(x="topleft", legend=names(empty_found), bty="n", fill=pal_col, cex=1.2)

# plot_layout(3, 1)
# 
# reflect_XSS=subset(EECS, vulnerability_class == "Reflected XSS")
# stored_XSS=subset(EECS, vulnerability_class == "Stored XSS")
# others=subset(EECS, vulnerability_class != "Reflected XSS" &
#                     vulnerability_class != "Stored XSS")
# 
# plot_fault_count(reflect_XSS, "Reflected XSS")
# plot_fault_count(stored_XSS, "Stored XSS")
# plot_fault_count(others, "Others")
# 
# legend(x="topleft", legend=names(empty_found), bty="n", fill=pal_col, cex=1.2)
# 

