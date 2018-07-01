#
# esem15-js-callbacks.R, 29 Jun 18
# Data from:
# Don't Call Us, We'll Call You: {Characterizing} Callbacks in {JavaScript}
# Keheliya Gallaba and Ali Mesbah and Ivan Beschastnikh
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG javascript callbacks arguments anonymous


source("ESEUR_config.r")


pal_col=rainbow(2)


cb=read.csv(paste0(ESEUR_dir, "sourcecode/esem15-js-callbacks.csv.xz"), as.is=TRUE)

cb=subset(cb, func_def_with_cb != 0)

# plot(cb$total_func_def, cb$func_def_with_cb, log="xy")
# 
# cb_mod=glm(log(func_def_with_cb) ~ log(total_func_def), data=cb)
# summary(cb_mod)


plot(cb$total_func_callsite, cb$func_callsite_with_cb, log="xy", col=pal_col[1],
	xlab="Total calls", ylab="Calls passing callbacks\n")
points(cb$total_func_callsite, cb$func_callsite_anon_cb, col=pal_col[2])

cs_mod=glm(log(func_callsite_with_cb) ~ log(total_func_callsite), data=cb)
# summary(cs_mod)

cb_ord=order(cb$func_callsite_with_cb)
pred=predict(cs_mod)
lines(cb$total_func_callsite[cb_ord], exp(pred[cb_ord]), col=pal_col[1]) 


anon_cb=subset(cb, func_callsite_anon_cb != 0)

as_mod=glm(log(func_callsite_anon_cb) ~ log(total_func_callsite), data=anon_cb)
# summary(as_mod)

as_ord=order(anon_cb$func_callsite_anon_cb)
pred=predict(as_mod)
lines(anon_cb$total_func_callsite[as_ord], exp(pred[as_ord]), col=pal_col[2]) 


legend(x="bottomright", legend=c("All callbacks", "Anonymous callbacks"), bty="n", fill=pal_col, cex=1.2)

