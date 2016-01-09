#
# web-avail.R, 28 Oct 13
#
# Based on data from:
# On Correlated Failures in Survivable Storage Systems
# Mehmet Bakkaloglu and Jay J. Wylie and Chenxi Wang and Gregory R. Ganger
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


web_avail=read.csv(paste0(ESEUR_dir, "probability/reliability/web-avail.csv.xz"), as.is=TRUE)
web_down=(web_avail == 0)

pair_prob=function(ind)
{
given=web_down[ , ind]
others=web_down[ , -ind]

# mean(P(X unavailable | Y unavailable))
# mean(P(X & Y unavailable) / P(Y unavailable))

both_down=(others & given)

av_prob=mean(colSums(both_down)/sum(given))

return(av_prob)
}


pair_down=sapply(1:ncol(web_down), pair_prob)

mean(pair_down)

mean(colSums(web_down)/nrow(web_down))

