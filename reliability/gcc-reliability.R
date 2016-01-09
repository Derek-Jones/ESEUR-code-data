#
# gcc-reliability.R,  2 Sep 15
#
# Data from:
#
# Empirical Assessment of Architecture-Based Reliability of Open-Source Software
# Ranganath Perugupalli
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

total_tests=2126

# Numbers from paper:
# Large Empirical Case Study of Architecture based Software Reliability
# Katerina Go\v{s}eva-Popstojanova and Margaret Hamill and Ranganath Perugupalli
# Table 2
gcc_trans_prob=matrix(nrow=13, byrow=TRUE,
c(0,       0.00053, 0.13470, 0,       0,       0,       0.00003, 0.06531, 0.00471, 0,       0.18134, 0.60951, 0.00387,
  0.39194, 0,       0.09140, 0.01114, 0,       0,       0,       0,       0.05387, 0,       0,       0.45166, 0.00000,
  0.35396, 0.00069, 0,       0.02593, 0.00395, 0.00559, 0.00001, 0.00468, 0.02698, 0,       0.01639, 0.56123, 0.00060,
  0.06769, 0.20704, 0.63969, 0,       0,       0,       0.04927, 0.00045, 0,       0,       0.03586, 0,       0,      
  0.38235, 0,       0.08589, 0,       0,       0,       0,       0,       0,       0,       0,       0.38235, 0.14941,
  0.55386, 0.04688, 0.17313, 0.00001, 0,       0,       0,       0.03471, 0,       0,       0,       0.19143, 0,
  0.03582, 0.59501, 0.16840, 0.18777, 0.00129, 0,       0,       0,       0,       0,       0.01171, 0,       0,
  0.00680, 0.02673, 0.96213, 0.00112, 0,       0,       0,       0,       0.00093, 0,       0.00185, 0.00044, 0,
  0.05920, 0.00225, 0.20549, 0.00650, 0,       0,       0,       0.00520, 0,       0,       0.00614, 0.69656, 0.01866,
  0.06525, 0.01021, 0.75907, 0.00520, 0,       0,       0.14369, 0.00681, 0.00349, 0,       0.00340, 0.00288, 0,
  0.05807, 0.00088, 0.05680, 0,       0,       0,       0,       0,       0.00000, 0,       0,       0.88372, 0.00053,
  0.09972, 0.00013, 0.02055, 0.00020, 0,       0,       0,       0,       0.85341, 0.00002, 0.02595, 0,       0.00001,
  0.07064, 0.00572, 0.08478, 0.02827, 0,       0.00249, 0.00613, 0.01332, 0.02698, 0.00497, 0.61022, 0.04247, 0))


# Table 2
R_n=0.10402

# Table 4
component_reliability=c(0.99999929,
		        0.99999946,
		        0.99999974,
		        1.0,
		        0.99999342,
		        0.99999539,
		        1.0,
		        1.0,
		        1.0,
		        1.0,
		        0.99999972,
		        0.99999989,
		        0.99999872)

error_prob = 1 - component_reliability

# Paper says those failures not be traced to one subcomponent
# were ignored.  Cannot pick and chose like that, so assume
# unassigned errors are equally distributed over existing
# errors (a better way of handling things).
# Numbers from Table 3
error_prob=error_prob*(85/57)
component_reliability=1-error_prob

init_state_prob = c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)
I_13=diag(13) # create Identity matrix

# Multiple the i'th entry in the columns of gcc_trans_prob by the
# i'th entry in component_reliability
Q = gcc_trans_prob * component_reliability

S = solve(I_13 - Q) # solve inverts when called with one argument

# Data contains probabilities not counts,
# so need to solve to get transition counts.
V = I_13 - gcc_trans_prob
u = solve(V, init_state_prob)

R_hier=S[1, ncol(S)]*R_n
R_comp = prod(component_reliability ^ u)


# Data from Perugupalli MSc
# Table 5.1
gcc_trans_count=read.csv(paste0(ESEUR_dir, "reliability/gcc-reliability-calls.csv.xz"),
		header=FALSE, as.is=TRUE)
err_cnt=read.csv(paste0(ESEUR_dir, "reliability/gcc-reliability-errors.csv.xz"), as.is=TRUE)

# Added counts for End state, which is absorbing (last row/column).  Actually only 2126 test cases.

# Convert element to a row probability
gcc_trans_prob=gcc_trans_count/rowSums(gcc_trans_count)
R_n=gcc_trans_prob[12, 13]

# remove last column
gcc_trans_prob=gcc_trans_prob[ , -ncol(gcc_trans_prob)]

# Table 6.3
fail_exec=data.frame(fail=c(30, 1, 7, 0, 1, 1, 0, 0, 0, 4, 10, 1),
                     comp_exec=rowSums(gcc_trans_count))
#
# The following values (from Table 6.3) should be the same as the
# above rowSums, but they are not:
#             comp_exec=c(1656221, 135180, 1688076, 162338,  11326,  57377,
#                           72680, 372486,   16087, 381046, 919668, 302504))

error_prob=fail_exec$fail/fail_exec$comp_exec
#error_prob=error_prob*2
component_reliability=1-error_prob
init_state_prob = c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)

I_12=diag(12) # create Identity matrix


# Multiple the i'th entry in the columns of gcc_trans_prob by the
# i'th entry in component_reliability
Q = gcc_trans_prob * component_reliability

S = solve(I_12 - Q) # solve inverts when called with one argument

R_comp=S[1, ncol(S)]*R_n

S_d=diag(S)*I_12
variance=S%*%(2*S_d-I_12)-(S^2)

R_hier=prod((1-fail_exec$fail/fail_exec$comp_exec)^(fail_exec$comp_exec/total_tests))


