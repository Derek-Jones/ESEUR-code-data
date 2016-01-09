#
# borda-sorted-year-plot.R, 22 Dec 15
#
# Data from:
#
# Learning a Metric for Code Readability"
# Raymond P. L. Buse and Westley R. Weimer
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


rating_to_rank=function(rating_vec)
{
# Return rankings for a single subject, based on the rating they gave
start_rank=0
subj_rank=vector(length=length(rating_vec))

# Loop over all ratings, calculate their equivalent rank and save this value.
for (s in 5:1)
   {
   num_rating=length(which(rating_vec == s))
   average_rank=(num_rating+1)/2
   subj_rank[rating_vec == s]=start_rank+(num_rating+1)/2
   start_rank=start_rank+num_rating
   }

return(subj_rank)
}


subj_rank=function(subj_rating)
{
# Return the items ranked for each subject
return (t(sapply(1:nrow(subj_rating),
                  function(x) {rating_to_rank(subj_rating[x, ])})))
}

aggreg_rank=function(subj_rank)
{
# Return a vector of the mean of each item's rank
# Uses Borda's aggregate original ranking algorithm
# Other metrics include Euclidian distance...

return (sapply(1:ncol(subj_rank),
                  function(x){mean(subj_rank[, x])}))
}

aggreg_rank_euclid=function(subj_rank)
{
# Return a vector of the Euclidean sum of each item's rank
# Uses Borda's aggregate original ranking algorithm

return (sapply(1:ncol(subj_rank),
                  function(x){sqrt(sum(subj_rank[, x]^2))}))
}

all_snip_data=read.csv(paste0(ESEUR_dir, "developers/readability/readability-tse.csv.xz"),
                   	header=FALSE, as.is=TRUE)

# 1st year students
cs1_snip_rating=all_snip_data[substr(all_snip_data[, 2], 1, 3) =="cs1", ][, -2:-1]
cs1_aggreg_rank=aggreg_rank(subj_rank(cs1_snip_rating))

# 2nd year students
cs2_snip_rating=all_snip_data[substr(all_snip_data[, 2], 1, 3) =="cs2", ][, -2:-1]
cs2_aggreg_rank=aggreg_rank(subj_rank(cs2_snip_rating))

# 4th year students
cs4_snip_rating=all_snip_data[substr(all_snip_data[, 2], 1, 3) =="cs4", ][, -2:-1]
cs4_aggreg_rank=aggreg_rank(subj_rank(cs4_snip_rating))



plot_layout(1, 2)

cs2.ord=order(cs2_aggreg_rank)
plot(cs2_aggreg_rank[cs2.ord], ylim=c(0,100),
      ylab="Aggregate rank", xlab="Subject")
points(cs1_aggreg_rank[cs2.ord], col="red")

plot(cs2_aggreg_rank[cs2.ord], ylim=c(0,100),
      ylab="", xlab="Subject")
points(cs4_aggreg_rank[cs2.ord], col="blue")

