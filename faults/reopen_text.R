#
# reopen_text.R, 19 Jun 16
#
# Data and (modified) code from:
# Predicting Re-opened Bugs: A Case Study on the Eclipse Project
# Emad Shihab and Akinori Ihara and Yasutaka Kamei and Walid M. Ibrahim and Masao Ohira and Bram Adams and Ahmed E. Hassan and Ken-ichi Matsumoto
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG faults-reopened Eclipse


source("ESEUR_config.r")


library(tm)


build_tdm=function(fault_text)
{
desc_text=Corpus(VectorSource(fault_text))

# Matrix containing count of each word in each 'document'
return(TermDocumentMatrix(desc_text,
			control=list(tolower=TRUE,
					removePunctuation=TRUE,
					stemming=stemDocument,
					stopwords=stopwords("english"))))
}


top_words=function(remod, top_count)
{
# How many cases in each category?
num_notreopened=length(which(remod == 0))
num_reopened=length(which(remod == 1))

reopened_ratio=num_reopened/num_notreopened

# Sum rows (term document is represented using a sparse array)
r0 = slam::row_sums(tdm[ , remod == 0])
r1 = slam::row_sums(tdm[ , remod == 1])

# Get top_count most frequent words from each case
r0.top50=head(sort(r0, decreasing=TRUE), n=top_count)
r1.top50=head(sort(r1, decreasing=TRUE), n=top_count)

# Merge the names of the two top top_count's
names.top50=union(names(r0.top50), names(r1.top50))

# Normalise by number of cases
r0.top50.norm=r0[names.top50]/num_notreopened
r1.top50.norm=r1[names.top50]/num_reopened

# Get percentage occurrence of each word (assumes words from
# one term document are in the other term document).
r0.top50.percent=sort(r0.top50.norm/(r0.top50.norm+r1.top50.norm))
r1.top50.percent=sort(r1.top50.norm/(r1.top50.norm+r0.top50.norm))

# Bayes rule gives us:
#
# P(S | W) =          P(W | S) P(S)
#            ----------------------------
#             P(W | S) P(S) + P(W | H) P(H)
# where:
#        S is reopened, H is non-reopened

psw=r1.top50.percent*reopened_ratio/(r1.top50.percent*reopened_ratio +
                                     r0.top50.percent/reopened_ratio)

# We need to combine the 'reopened' probability for each word
# contained in the text for a given fault.
# The naive Bayes classifier formula is:
#
# P =              psw1 psw2 ... pswn
#     -----------------------------------------------------
#      psw1 psw2 ... pswn + (1-psw1) (1-psw2) ... (1-pswn)


set_word_psw=function(x)
{
wc=as.matrix(tdm[x, ])
return((wc > 0)*psw[x])
}

# Set each non-zero word count entry to psw value
psw.top50=sapply(names.top50, set_word_psw)


# Now combine every non-zero word probability
psw_prod=sapply(1:(num_reopened+num_notreopened),
              function(x){w=psw.top50[x,] ; return(prod(w[w>0], na.rm=TRUE)) })

psw_m1_prod=sapply(1:(num_reopened+num_notreopened),
              function(x){w=psw.top50[x,] ; return(prod(1-w[w>0], na.rm=TRUE)) })

# Naive Bayes calculation
P=psw_prod/(psw_prod+psw_m1_prod)

return (P)
}


reopened_data=read.csv(paste0(ESEUR_dir, "faults/reopened_fault.data.xz"), as.is=TRUE)

tdm=build_tdm(reopened_data$description)
description_nbc_50=top_words(reopened_data$remod, 50)
description_nbc_25=top_words(reopened_data$remod, 25)
description_nbc_15=top_words(reopened_data$remod, 15)

cor.test(description_nbc_50, remod)
cor.test(description_nbc_25, remod)
cor.test(description_nbc_15, remod)

tdm=build_tdm(reopened_data$comments)
comments_nbc_50=top_words(reopened_data$remod, 50)
comments_nbc_25=top_words(reopened_data$remod, 25)
comments_nbc_15=top_words(reopened_data$remod, 15)

cor.test(comments_nbc_50, remod)
cor.test(comments_nbc_25, remod)
cor.test(comments_nbc_15, remod)

