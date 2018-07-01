#
# pref-attach-access.R,  6 Jan 16
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

# Simulate preferential attachment process
#
# p * (k-1)/N  + (1-p)/N


source("ESEUR_config.r")

MAX_LOCALS=100
NUM_REFS=100
NUM_REPLICATE=1000
access_bounds=1:20

cut_off=0.20

local_list=rep(1, MAX_LOCALS)
num_locals=1


ref_existing=function()
{
#ref_count=cumsum(0.5*num_locals+local_list[1:num_locals])
ref_count=cumsum(local_list[1:num_locals])
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
if (runif(1) > cut_off)
#if (runif(1) > 1/(1+0.5*num_locals))
   ref_existing()
else
   new_local()
}


pref_attach=function(num_iter)
{
local_list <<- rep(1, MAX_LOCALS)
num_locals <<- 1

replicate(num_iter, add_ref())

local_list[(num_locals+1):MAX_LOCALS] <<- 0

return(sort(local_list, decreasing=TRUE))
}


# Measurements of existing code.
# total access,object access,occurrences
access_data=read.csv(paste0(ESEUR_dir, "sourcecode/local-use/acc-per-obj.csv.xz"),
			as.is=TRUE)


# Sum object access counts over a band of total access
# Should reduce noise a bit.
band_obj=function(b_center)
{
ob=subset(access_data, (total.access >= (b_center-4)) & (total.access <= (b_center+4)))

ob_occur=sapply(access_bounds, function(X) sum(ob$occurrences[ob$object.access == X]))

return(ob_occur)
}


plot_band=function(b_center)
{
b100=band_obj(b_center)
b100=100*b100/b100[1]

plot(b100, ylim=c(0, 100), col="blue",
	ylab="Occurrences", xlab="Read accesses")
text(15, 90, paste0("P=", cut_off))


nls_mod=nls(b100 ~ a*exp(b*access_bounds), start=list(a=100, b=-0.1))

lines(predict(nls_mod), col="green")
# Get calculated values of a and b
nls_sum=summary(nls_mod)$parameters[1:2, 1]

t=replicate(NUM_REPLICATE, pref_attach(b_center))
q=table(t)
q=trunc(100*q[-1]/q[2])

lines(q[access_bounds], col="red")

}


plot_layout(1, 2)
par(mai=c(1.0, 0.9, 0.1, 0.4))

cut_off=0.05
plot_band(100)
cut_off=0.0004
plot_band(100)


