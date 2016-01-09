#
# sorted-agg-year-cor.R, 10 Oct 12
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
# Data from paper "Learning a Metric for Code Readability",
# by Raymond P. L. Buse and Westley R. Weimer
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

cs1_subj_rank=subj_rank(cs1_snip_rating)
cs1_rank_cor=sapply(1:nrow(cs1_subj_rank),
                     function(x){cor.test(cs1_aggreg_rank, cs1_subj_rank[x,], method="kendal")$estimate})

cs2_subj_rank=subj_rank(cs2_snip_rating)
cs2_rank_cor=sapply(1:nrow(cs2_subj_rank),
                     function(x){cor.test(cs2_aggreg_rank, cs2_subj_rank[x,], method="kendal")$estimate})

cs4_subj_rank=subj_rank(cs4_snip_rating)
cs4_rank_cor=sapply(1:nrow(cs4_subj_rank),
                     function(x){cor.test(cs4_aggreg_rank, cs4_subj_rank[x,], method="kendal")$estimate})


x=seq(1, 100, by=100/length(cs1_rank_cor))
y=sort(cs1_rank_cor)
plot(x, y, col="green",
     xlim=c(1, 100), ylim=c(0.0, 0.8), xaxt="n",
     xlab="Individual subjects", ylab="Correlation with year aggregate\n")
abline(lm(y ~ x)$coefficients)
text(60, 0.14, pos=4,
        label=paste("1st    ",
                    round(mean(cs1_rank_cor), digits=2), " ",
                    round(sd(cs1_rank_cor), digits=2)))

x=seq(1, 100, by=100/length(cs2_rank_cor))
y=sort(cs2_rank_cor)
points(x, y, col="blue")
abline(glm(y ~ x)$coefficients)
text(60, 0.17, pos=4,
        label=paste("2nd   ",
                    round(mean(cs2_rank_cor), digits=2), " ",
                    round(sd(cs2_rank_cor), digits=2)))

x=seq(1, 100, by=100/length(cs4_rank_cor))
y=sort(cs4_rank_cor)
points(x, y, col="red")

abline(glm(y ~ x)$coefficients)
text(60, 0.2, pos=4,
        label=paste("4th    ",
                    round(mean(cs4_rank_cor), digits=2), " ",
                    round(sd(cs4_rank_cor), digits=2)), cex=1.3)

text(60, 0.24, pos=4, label="year  mean   sd", cex=1.3)

