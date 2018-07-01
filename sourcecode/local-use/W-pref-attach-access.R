#
# L-pref-attach-access.R, 20 Jul 16
#
# Simulate weighted preferential attachment process
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

library("plyr")

plot_layout(4, 1)
# par(mai=c(0.7, 0.7, 0.1, 0.2))


MAX_LOCALS=100
NUM_REPLICATE=1000
access_bounds=1:20
b_width=4

local_list=rep(1, MAX_LOCALS)
num_locals=1


ref_existing=function()
{
# Calculate access probability for each variable
ref_count=cumsum(0.5*num_locals+local_list[1:num_locals])

# Randomly select one
rand_ref=ceiling(runif(1, min=0, max=ref_count[num_locals]))
var_ref=num_locals+1-length(which(rand_ref <= ref_count))

#print(c(var_ref, rand_ref, ref_count))

local_list[var_ref] <<- local_list[var_ref]+1
}


new_local=function()
{
num_locals <<- num_locals+1
}


add_ref=function()
{
#if (runif(1) > cut_off)
if (runif(1) > 1/(1+0.5*num_locals))
   ref_existing()
else
   new_local()
}


pref_attach=function(num_iter)
{
# Initialize a list of locals
local_list <<- rep(1, MAX_LOCALS)
num_locals <<- 1

replicate(num_iter, add_ref())

# Zero out the counts for locals that were not accessed
local_list[(num_locals+1):MAX_LOCALS] <<- 0

return(sort(local_list, decreasing=TRUE))
}

# t=pref_attach(100)
# 
# plot(t[1:num_locals], log="y",
#       xlim=c(1, 20), ylim=c(1, 55))
# 
# 
# t=replicate(NUM_REPLICATE, pref_attach(NUM_REFS))
# q=table(t)
# q=trunc(100*q[-1]/q[2])
# 
# plot(fitted, ylim=c(0, 100))
# points(q[1:20], col="red")


# Measurements of existing code.
# total access,object access,occurrences
access_data=read.csv(paste0(ESEUR_dir, "sourcecode/local-use/acc-per-obj.csv.xz"),
			as.is=TRUE)


# Sum object access counts over a band of total access
# Should reduce noise a bit.
band_obj=function(b_center)
{
ob=subset(access_data, (total.access >= (b_center-b_width)) & (total.access <= (b_center+b_width)))

ob_occur=sapply(access_bounds, function(X) sum(ob$occurrences[ob$object.access == X]))

return(ob_occur)
}


plot_band=function(b_center)
{
b100=band_obj(b_center)
b100=100*b100/b100[1]

plot(b100, ylim=c(0, 100), col="blue",
	ylab="Occurrences", xlab="Read accesses")
text(13, 90, paste0("Total access=", b_center))

# Create a specific fit for this data
# nls_mod=nls(b100 ~ a*exp(b*access_bounds), start=list(a=100, b=-0.1))
# nls_pred=predict(nls_mod)

total_df=data.frame(total.access=b_center, object.access=access_bounds)

nls_pred=predict(nls_mod, total_df)
nls_pred=100*nls_pred/nls_pred[1]

lines(nls_pred, col="green")
# Get calculated values of a and b
nls_sum=summary(nls_mod)$parameters[1:2, 1]

t=replicate(NUM_REPLICATE, pref_attach(b_center))
q=table(t)
q=trunc(100*q[-1]/q[2])

points(q[access_bounds], col="red")

}


# Remove 'edge' cases
ob_all=subset(access_data, (total.access > 5) & (total.access < 105) &
                           (object.access <= 20))

# Normalise number of occurrences, with '1' object.access being 100
ob_norm=ddply(ob_all, .(total.access),
		function(df)
		{
		t=sum(df$occurrences)
		df$occurrences=100*df$occurrences/t
		return(df)
		})

# Two exponentials not significant in d
#nls_mod=nls(occurrences ~ a*exp(b*object.access)+c*exp(d*total.access),

nls_mod=nls(occurrences ~ a*exp(b*object.access+c*total.access),
		data=ob_norm, start=list(a=100, b=-0.1, c=0.01))

# Lower total.access counts tend to have more occurrences,
# so smoothing need not cast such a wide net
b_width=2
plot_band(25)
b_width=3
plot_band(50)
b_width=4
plot_band(75)
plot_band(100)

