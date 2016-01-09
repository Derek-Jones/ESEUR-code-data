#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

simkpair=function(k,error)
{
# advantage distribution
a = (-5*nn):(5*nn)/nn # advantage to i
pr_a = dnorm(a) # probability density for a
pr_a = pr_a / sum(pr_a) # normalize density to create probabilities
# probabilities of claiming and winning
if(error=="normal")
   {
   i_claims = pnorm( a + k[1], sd=e) # probability i makes a claim
   j_claims = pnorm(-a + k[2], sd=e) # probability j makes a claim
   } else if(error=="binomial") {
   i_claims = 0.5*( a + k[1] + e > 0) + 0.5*( a + k[1] - e > 0) # probability i makes a claim
   j_claims = 0.5*(-a + k[2] + e > 0) + 0.5*(-a + k[2] - e > 0) # probability j makes a claim
} else {
   return("need to specify binomial or normal error")
   }
i_wins = a > 0 # determine if i beats j
i_ties = which(a == 0) # determine when i ties j
# payoffs
# r if i fights and j does not fight,
# r-c if j fights and i wins, and
# -c if j fights and i loses,
# 0 otherwise
payoffs_i = i_claims * (j_claims * ifelse(i_wins, r - c_win, - c) + (1 - j_claims) * r)
# if i and j tie, there is a 0.5 chance i wins
payoffs_i[i_ties] = i_claims[i_ties] *
j_claims[i_ties] * (0.5 * (r - c_win) + 0.5 * (- c) + (1 - j_claims[i_ties]) * r)
# return payoffs
return(sum(payoffs_i * pr_a ))
}

