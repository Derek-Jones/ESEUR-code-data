#
# jones_prec.R,  6 Jun 18
# Data from:
# Developer Beliefs about Binary Operator Precedence
# Derek M. Jones
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG experiment developer operator belief source-code


source("ESEUR_config.r")


library("BradleyTerry2")


# subj_num,first_op,second_op,prec_order,is_correct,years_exp
# prec_order: first_high=1, equal_prec=2, second_high=3
bin_prec=read.csv(paste0(ESEUR_dir, "developers/jones_bin_prec.csv.xz"), as.is=TRUE)

# Remove equal precedence
nodraws=subset(bin_prec, prec_order != 2)

# Map actual relative precedence and correctness of question back to
# answer given.
first_wl=matrix(data=c(0, 1,
		       0, 0,
		       1, 0), nrow=2, ncol=3)
second_wl=matrix(data=c(1, 0,
		        0, 0,
		        0, 1), nrow=2, ncol=3)

nodraws$first_wl=first_wl[cbind(1+nodraws$is_correct, nodraws$prec_order)]
nodraws$second_wl=second_wl[cbind(1+nodraws$is_correct, nodraws$prec_order)]
prec_BT=BTm(cbind(first_wl, second_wl), first_op, second_op, data=nodraws)

# summary(prec_BT)


# t=BTabilities(prec_BT)
# plot(qvcalc(t[order(t[, 1]),]))

plot(qvcalc(BTabilities(prec_BT)), col=point_col,
	main="",
	xlab="Operator", ylab="Estimate")


Check for a home team effect, i.e., a preference for the
operator appearing first/second.

# library("dply")
# 
# # Sum all cases where each operator appeared first and 'won' against
# # particular second operators.
# all_first_wins=function(df)
# {
#    second_looses=function(df)
#    {
#    return(sum(df$first_wl))
#    }
# 
# return(ddply(df, .(second_op), second_looses))
# }
# 
# 
# # Sum all cases where each operator appeared second and 'won' against
# # particular first operators.
# all_second_wins=function(df)
# {
#    first_looses=function(df)
#    {
#    return(sum(df$second_wl))
#    }
# 
# return(ddply(df, .(first_op), first_looses))
# }
# 
# 
# 
# first_wins=ddply(nodraws, .(first_op), all_first_wins)
# first_wins$first_wl=first_wins$V1
# first_wins$V1=NULL
# 
# second_wins=ddply(nodraws, .(second_op), all_second_wins)
# second_wins$second_wl=second_wins$V1
# second_wins$V1=NULL
# 
# # Combine first and second 'wins'
# first_second=merge(first_wins, second_wins, all=TRUE)
# 
# prec_BT=BTm(cbind(first_wl, second_wl), first_op, second_op,
# 			data=first_second, id="op")
# 
# summary(prec_BT)
# 
# # Update model with is first, possible (dis)advantage, information
# first_second$first_op=data.frame(op = first_second$first_op, is_first = 1)
# first_second$second_op=data.frame(op = first_second$second_op, is_first = 0)
# 
# ord_prec_BT=update(prec_BT, formula= ~ op+is_first)
# summary(ord_prec_BT)
# 

