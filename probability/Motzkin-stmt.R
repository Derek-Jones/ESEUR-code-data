#
# Motzkin.R, 12 Apr 20

library("numbers") # implements the catalan function


# Corollary 2.1 from
# Exact, time-independent estimation of clone size distributions in normal and mutated cells
# A. Roshan, P. H. Jones and C. D. Greenman
length_prob=function(n)
{
   bin_cat_frac=function(i)
   {
   t=choose(n-2, 2*i)*catalan(2*i)*a^i*b^(n-2-2*i)*c^(i+1)
   
   return(t)
   }

prob=0

for (i in 0:trunc((n-2)/2))
   {
   prob=prob+bin_cat_frac(i)
   }

return(prob)
}



a=0.1    # Up
c=0.2    # Down
b=1-a-c  # Level

n_bounds=10:30

l_p=sapply(n_bounds, length_prob)

plot(n_bounds+1, l_p, log="y",
	xlab="n", ylab="Probability\n")

