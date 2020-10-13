#
# RTdistPalmer-quest.R, 27 Aug 20
# Data from:
# Example derived from:
# What Are the Shapes of Response Time Distributions in Visual Search?
# Evan M. Palmer and Todd S. Horowitz and Antonio Torralba and Jeremy M. Wolfe
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example experiment_human

source("ESEUR_config.r")


plot_layout(1, 3, default_height=6)
par(mar=c(0.1, 0.2, 0.1, 0))


plot_condition=function(df)
{
   subj_mean=function(df, line_lty, pt_pch)
   {
   col_str=df$col_str[1]
   smean=ddply(df, .(Setsize, Subject), function(df) mean(df$RT))
   points(jitter(smean$Setsize), smean$V1, col=col_str, pch=pt_pch)
   ps_mod=glm(RT ~ Setsize, data=df)
   pred=predict(ps_mod, newdata=data.frame(Setsize=x_bounds))
   lines(x_bounds, pred, col=col_str, lty=line_lty)
   }

x_bounds=unique(df$Setsize)

present=subset(df, Targ_Pres == 1)
missing=subset(df, Targ_Pres == 0)

subj_mean(present, 1, "+")
subj_mean(missing, 2, "o")
}


vert_rect=function(x_b, y_b, border_col="green", fill_col="white")
{
b_col=ifelse(fill_col == "white", border_col, fill_col)

polygon(c(x_b-0.2, x_b+0.2, x_b+0.2, x_b-0.2),
        c(y_b-0.6, y_b-0.6, y_b+0.6, y_b+0.6), border=b_col, col=fill_col)
}

horiz_rect=function(x_b, y_b)
{
polygon(c(x_b-0.6, x_b+0.6, x_b+0.6, x_b-0.6),
        c(y_b-0.2, y_b-0.2, y_b+0.2, y_b+0.2), border="red", col="red")
}


big_5=function(x_b, y_b)
{
lines(c(x_b, x_b-0.3, x_b-0.3, x_b,     x_b,     x_b-0.3),
	c(y_b, y_b,     y_b-0.3, y_b-0.3, y_b-0.6, y_b-0.6),
	lwd=1.3)
}


big_2=function(x_b, y_b)
{
lines(c(x_b, x_b+0.3, x_b+0.3, x_b,     x_b,     x_b+0.3),
	c(y_b, y_b,     y_b-0.3, y_b-0.3, y_b-0.6, y_b-0.6),
	lwd=1.3)
}


plot(0, type="n", bty="o", xaxt="n", yaxt="n", fg="grey",
	xlim=c(0, 10), ylim=c(0, 10),
	xlab="", ylab="")

vert_rect(1, 9.1); vert_rect(3.1, 8.9); vert_rect(6, 9.2); vert_rect(9.1, 9)
vert_rect(1.3, 7.1); vert_rect(4.7, 7.3); vert_rect(6.3, 7.2);
vert_rect(3.0, 5.1);                  vert_rect(4.8, 5.0); vert_rect(9.3, 5.2);
vert_rect(0.9, 3.0); vert_rect(3.2, 3.1, fill_col="red");
				 vert_rect(6.2, 3.3); vert_rect(9.3, 3.2);
vert_rect(1, 1.1); vert_rect(5.1, 1.2); vert_rect(7, 1.2); vert_rect(9.1, 1)

plot(0, type="n", bty="o", xaxt="n", yaxt="n", fg="grey",
	xlim=c(0, 10), ylim=c(0, 10),
	xlab="", ylab="")

vert_rect(1.3, 8.4); vert_rect(4.7, 7.9); vert_rect(9.3, 9.1);
vert_rect(3.1, 5.4); vert_rect(8.2, 7.3); vert_rect(9.1, 4.9)
vert_rect(1.1, 2.4); vert_rect(5.2, 2.1, fill_col="red"); vert_rect(9.2, 2.3);
vert_rect(3.1, 1.2);

horiz_rect(2.8, 9.0); horiz_rect(7.1, 8.9)
horiz_rect(0.9, 6.6); horiz_rect(5.6, 6.7)
horiz_rect(3.1, 3.4); horiz_rect(7.1, 5.1)
horiz_rect(0.6, 0.8); horiz_rect(7.1, 0.9)

plot(0, type="n", bty="o", xaxt="n", yaxt="n", fg="grey",
	xlim=c(0, 10), ylim=c(0, 10),
	xlab="", ylab="")

big_5(1, 9.1); big_5(3.1, 8.9); big_5(6, 9.2); big_5(9.1, 9)
big_5(1.3, 7.1); big_5(4.7, 7.3); big_2(6.3, 7.2)
big_5(3.0, 5.1);                  big_5(6.8, 5.0); big_5(9.3, 5.2);
big_5(0.9, 3.0); big_5(3.2, 3.1)
				 big_5(6.2, 3.3); big_5(9.3, 3.2);
big_5(1, 1.1); big_5(5.1, 1.2); big_5(7, 1.2); big_5(9.1, 1)


