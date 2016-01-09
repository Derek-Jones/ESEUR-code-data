#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

simkvec<-function(k)
{
# randomly match each i, j, h
trios=matrix(sample(k),ncol=3) # generate random trios
k_i=trios[,1]
k_j=trios[,2]
k_h=trios[,3]
# errors and advantages
theta_i=rnorm(n/3,0,sqrt(2)/2) # capability of i
theta_j=rnorm(n/3,0,sqrt(2)/2) # capability of j
theta_h=rnorm(n/3,0,sqrt(2)/2) # capability of h
a_ij=theta_i-theta_h # endowment advantage of i over j
a_ih=theta_i-theta_h # endowment advantage of i over h
a_jh=theta_j-theta_h # endowment advantage of j over h
e_ij=rnorm(n/3,0,e) # errors in i perception of j
e_ih=rnorm(n/3,0,e) # errors in i perception of h
e_ji=rnorm(n/3,0,e) # errors in j perception of i
e_jh=rnorm(n/3,0,e) # errors in j perception of h
e_hi=rnorm(n/3,0,e) # errors in h perception of i
e_hj=rnorm(n/3,0,e) # errors in h perception of j
# determine if i makes a claim
i_claims = (( a_ij + e_ij + k_i) > 0) & (( a_ih + e_ih + k_i) > 0)
# determine if i makes a claim
j_claims = (( -a_ij + e_ji + k_j) > 0) & (( a_jh + e_jh + k_j) > 0)
# determine if i makes a claim
h_claims = (( -a_ih + e_hi + k_h) > 0) & (( -a_jh + e_hj + k_j) > 0)
# probabilities of winning
i_wins = (a_ij > 0) & (a_ih > 0) # determine if i beats j and h
j_wins = (-a_ij > 0) & (a_jh > 0) # determine if j beats i and h
h_wins = (-a_ih > 0) & (-a_jh > 0) # determine if h beats i and j
# payoffs
# r if one individual claims and others do not claim,
# r-c if two or more individuals fight and a individual wins, and
# -c if two or more individuals fight and a individual loses,
# 0 otherwise
payoffs_i = i_claims * ifelse(j_claims|h_claims, i_wins*r - c, r)
payoffs_j = j_claims * ifelse(i_claims|h_claims, j_wins*r - c, r)
payoffs_h = h_claims * ifelse(i_claims|j_claims, h_wins*r - c, r)
# return payoffs
return(cbind(c(k_i,k_j,k_h),c(payoffs_i,payoffs_j,payoffs_h)))
}

