#
# readability-snip.R, 30 Dec 15
#
# Data from:
# Learning a Metric for Code Readability
# Raymond P. L. Buse and Westley R. Weimer
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


subj_mean_rating=function(snippet_rating)
{
return(sapply(1:nrow(snippet_rating),function(x){mean(t(snippet_rating[x,]))}))
}

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

# Remove subject id and course attending
subj_snip_rating=all_snip_data[, -2:-1]

plot_layout(2, 2)
# Snippet mean
hist(mean(subj_snip_rating), breaks=10)

# Subject mean
all_subj_mean=subj_mean_rating(subj_snip_rating)
# hist(all_subj_mean, breaks=10)

mean_breaks=seq(1.5, 5.0, 0.5)
# 1st year students
cs1_subj_mean=subj_mean_rating(all_snip_data[substr(all_snip_data[, 2], 1, 3) =="cs1", ][, -2:-1])
hist(cs1_subj_mean, breaks=mean_breaks)
# 2nd year students
cs2_subj_mean=subj_mean_rating(all_snip_data[substr(all_snip_data[, 2], 1, 3) =="cs2", ][, -2:-1])
hist(cs2_subj_mean, breaks=mean_breaks)
# 4th year students
cs4_subj_mean=subj_mean_rating(all_snip_data[substr(all_snip_data[, 2], 1, 3) =="cs4", ][, -2:-1])
hist(cs4_subj_mean, breaks=mean_breaks)

c(sd(cs1_subj_mean), sd(cs2_subj_mean), sd(cs4_subj_mean))
c(mean(cs1_subj_mean), mean(cs2_subj_mean), mean(cs4_subj_mean))

# Rank subject responses and obtain an aggregate rankings
all_subj_rank=subj_rank(subj_snip_rating)
all_aggreg_rank=aggreg_rank(all_subj_rank)

# 1st year students
cs1_snip_rating=all_snip_data[substr(all_snip_data[, 2], 1, 3) =="cs1", ][, -2:-1]
cs1_aggreg_rank=aggreg_rank(subj_rank(cs1_snip_rating))
cs1_1_20_rank=aggreg_rank(subj_rank(cs1_snip_rating[, 1:20]))

# 2nd year students
cs2_snip_rating=all_snip_data[substr(all_snip_data[, 2], 1, 3) =="cs2", ][, -2:-1]
cs2_aggreg_rank=aggreg_rank(subj_rank(cs2_snip_rating))
cs2_1_20_rank=aggreg_rank(subj_rank(cs2_snip_rating[, 1:20]))
cs2_21_40_rank=aggreg_rank(subj_rank(cs2_snip_rating[, 21:40]))
cs2_41_60_rank=aggreg_rank(subj_rank(cs2_snip_rating[, 41:60]))

# 4th year students
cs4_snip_rating=all_snip_data[substr(all_snip_data[, 2], 1, 3) =="cs4", ][, -2:-1]
cs4_aggreg_rank=aggreg_rank(subj_rank(cs4_snip_rating))
cs4_1_20_rank=aggreg_rank(subj_rank(cs4_snip_rating[, 1:20]))


cor.test(cs1_aggreg_rank, cs2_aggreg_rank, method="kendal")
cor.test(cs1_aggreg_rank, cs4_aggreg_rank, method="kendal")
cor.test(cs2_aggreg_rank, cs4_aggreg_rank, method="kendal")

cs1_subj_rank=subj_rank(cs1_snip_rating)
cs1_rank_cor=sapply(1:nrow(cs1_subj_rank),
                     function(x){cor.test(cs1_aggreg_rank, cs1_subj_rank[x,], method="kendal")$estimate})

cs2_subj_rank=subj_rank(cs2_snip_rating)
cs2_rank_cor=sapply(1:nrow(cs2_subj_rank),
                     function(x){cor.test(cs2_aggreg_rank, cs2_subj_rank[x,], method="kendal")$estimate})

cs4_subj_rank=subj_rank(cs4_snip_rating)
cs4_rank_cor=sapply(1:nrow(cs4_subj_rank),
                     function(x){cor.test(cs4_aggreg_rank, cs4_subj_rank[x,], method="kendal")$estimate})

plot_layout(1, 1)

x=seq(1, 100, by=100/length(cs1_rank_cor))
y=sort(cs1_rank_cor)
plot(x, y, col="green",
     xlim=c(1, 100), ylim=c(0.0, 0.8), xaxt="n",
     xlab="Individual subjects", ylab="Correlation with year aggregate")
abline(lm(y ~ x)$coefficients, col="green")
text(60, 0.14, pos=4,
        label=paste("1st    ",
                    round(mean(cs1_rank_cor), digits=2), " ",
                    round(sd(cs1_rank_cor), digits=2)))
par(new=TRUE)
x=seq(1, 100, by=100/length(cs2_rank_cor))
y=sort(cs2_rank_cor)
plot(x, y, col="blue",
     xlim=c(1, 100), ylim=c(0.0, 0.8), xaxt="n",
     xlab="", ylab="")
abline(lm(y ~ x)$coefficients, col="blue")
text(60, 0.17, pos=4,
        label=paste("2nd   ",
                    round(mean(cs2_rank_cor), digits=2), " ",
                    round(sd(cs2_rank_cor), digits=2)))
par(new=TRUE)
x=seq(1, 100, by=100/length(cs4_rank_cor))
y=sort(cs4_rank_cor)
plot(x, y, col="red",
     xlim=c(1, 100), ylim=c(0.0, 0.8), xaxt="n",
     xlab="", ylab="")
abline(lm(y ~ x)$coefficients, col="red")
text(60, 0.2, pos=4,
        label=paste("4th    ",
                    round(mean(cs4_rank_cor), digits=2), " ",
                    round(sd(cs4_rank_cor), digits=2)))

text(60, 0.24, pos=4, label="year  mean   sd")


# Source code measures

snipstat=read.csv(paste0(ESEUR_dir, "developer/readability/snippet-stats.csv.xz"), as.is=TRUE)

plot_layout(1, 2)
plot(cs4_aggreg_rank, snipstat$length/snipstat$num_nb_lines,
      xlab="Aggregate rank", ylab="Average line length")
plot(cs4_aggreg_rank, snipstat$num_id/snipstat$num_nb_lines,
      xlab="Aggregate rank", ylab="Average identifiers per line")

cor.test(cs4_aggreg_rank, snipstat$length/snipstat$num_nb_lines, method="kendal")
cor.test(cs4_aggreg_rank, snipstat$num_id/snipstat$num_nb_lines, method="kendal")
cor.test(snipstat$length/snipstat$num_nb_lines, snipstat$num_id/snipstat$num_nb_lines, method="kendal")

library("irr")

cs1_subj=all_snip_data[substr(all_snip_data[, 2], 1, 3) =="cs1", ][, -2:-1]
cs2_subj=all_snip_data[substr(all_snip_data[, 2], 1, 3) =="cs2", ][, -2:-1]
cs4_subj=all_snip_data[substr(all_snip_data[, 2], 1, 3) =="cs4", ][, -2:-1]

boxplot(cs1_subj[,1:50], col=c("light blue", "pink"))
boxplot(cs2_subj[,1:50], col=c("light blue", "pink"))
boxplot(cs4_subj[,1:50], col=c("light blue", "pink"))

kripp.alpha(as.matrix(cs1_subj), method="ordinal")
kripp.alpha(as.matrix(cs2_subj), method="ordinal")
kripp.alpha(as.matrix(cs4_subj), method="ordinal")

meanrho(t(cs1_subj))
meanrho(t(cs2_subj))
meanrho(t(cs4_subj))

# Try again on only those snippets having a rating SD less than 1
kripp.alpha(as.matrix(cs1_subj[ , apply(cs1_subj, 2, sd) < 1]), method="ordinal")
kripp.alpha(as.matrix(cs2_subj[ , apply(cs2_subj, 2, sd) < 1]), method="ordinal")
kripp.alpha(as.matrix(cs4_subj[ , apply(cs4_subj, 2, sd) < 1]), method="ordinal")

length(which(apply(cs2_subj, 2, sd) < 1)) / ncol(cs2_subj)


plot_layout(1, 2)
cs2.ord=order(cs2_aggreg_rank)
plot(cs2_aggreg_rank[cs2.ord], ylim=c(0,100),
      ylab="Aggregate rank")
par(new=TRUE)
plot(cs1_aggreg_rank[cs2.ord], col="red", ylim=c(0,100),
      ylab="")
plot(cs2_aggreg_rank[cs2.ord], ylim=c(0,100),
      ylab="")
par(new=TRUE)
plot(cs4_aggreg_rank[cs2.ord], col="blue", ylim=c(0,100),
      ylab="")

