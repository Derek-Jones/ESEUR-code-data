#
# supply-demand.R,  5 Mar 17
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(2, 1, max_height=10, default_width=6)

pal_col=rainbow(2)


p1_eq=function(quant)
{
return(10*(2+quant^-0.5))
}

q1_eq=function(price)
{
return((price/10-2)^-2)
}


p2_eq=function(quant)
{
return(10*(2.1+(quant-10)^-0.5))
}


q2_eq=function(price)
{
return((price/10-2.1)^-2+10)
}


s1_eq=function(quantity)
{
return(20+(quantity+(0.1*quantity)^2)/40)
}


s2_eq=function(quantity)
{
return(2.5+s1_eq(quantity))
}


quantity=3:100
price_1=p1_eq(quantity)
price_2=p2_eq(quantity)

plot(quantity, price_1, type="l", col=pal_col[1],
	xlab="Quantity", ylab="Price")

lines(quantity, price_2, col=pal_col[2])

q=56
p=p2_eq(q)

arrows(q, p2_eq(q), q, p1_eq(q), length=0.1)
arrows(q2_eq(p), p, q1_eq(p), p, length=0.1)

text(58, (p1_eq(58)+p2_eq(58))/2-0.2, "Reduced willingness to\npay for same quantity",
		pos=4, cex=1.2)
text(q1_eq(p2_eq(q))-2, p2_eq(q)+0.5, "Smaller\nquantity\ndemanded at\nsame price",
		pos=4, cex=1.2)

text(47, p2_eq(47)+0.2, "Demand curve\nat higher price", pos=4, cex=1.2)
text(30, p1_eq(30)-0.3, "Demand curve\nat lower price", pos=2, cex=1.2)

price_3=s1_eq(quantity)
price_4=s2_eq(quantity)

plot(quantity, price_3, type="l", col=pal_col[1],
	ylim=range(price_1),
	xlab="Quantity", ylab="Price")
lines(quantity, price_4, col=pal_col[2])
text(60, s1_eq(60)-0.3, "Supply curve\nat lower price", pos=4, cex=1.2)
text(50, s2_eq(50)+0.2, "Supply curve\nat higher price", pos=2, cex=1.2)


q=40
p=s2_eq(q)

arrows(q, s2_eq(q), q, s1_eq(q), length=0.1)
arrows(q, p, 84, p, length=0.1)

text(84, p+0.5, "Greater\nquantity\nat same\nprice", pos=2, cex=1.2)
text(q, (s2_eq(q)+s1_eq(q))/2-0.3, "Same\nquantity\nat lower\nprice", pos=2, cex=1.2)

# 
# plot(quantity, price_1, type="l", col=pal_col[1],
# 	xlab="Quantity", ylab="Price")
# 
# lines(quantity, price_2, col=pal_col[2])
# lines(quantity, 1+price_3, col=pal_col[3])
# 
# 
