#
# anscombe.R, 12 Mar 14
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

# anscombe is an object defined in the base package
a1=with(anscombe, data.frame(x=c(x1), y=c(y1)))
a2=with(anscombe, data.frame(x=c(x2), y=c(y2)))
a3=with(anscombe, data.frame(x=c(x3), y=c(y3)))
a4=with(anscombe, data.frame(x=c(x4), y=c(y4)))

plot_layout(2, 2)

plot_anscombe=function(x_y)
{

y_min=3
y_max=13
x_min=4
x_max=19

plot(x_y, col="red",
	xlim=c(x_min, x_max), ylim=c(y_min, y_max))

glm_fit=glm(y ~ x, data=x_y)
abline(reg=glm_fit, col="green")


# text(x=x_min+13, y=y_min+4.0, label="mean")
# text(x=x_min+13, y=y_min+3.4, label=paste("x=", round(mean(x_y$x), digits=5)))
# text(x=x_min+13, y=y_min+2.6, label=paste("y=", round(mean(x_y$y), digits=5)))
# text(x=x_min+13, y=y_min+1.7, label="sd")
# text(x=x_min+13, y=y_min+1.0, label=paste("x=", round(sd(x_y$x), digits=5)))
# text(x=x_min+13, y=y_min+0.2, label=paste("y=", round(sd(x_y$y), digits=5)))
# 
# text(x=x_min+2, y=y_max-0.4, label="correlation")
# text(x=x_min+2, y=y_max-1.2, label=round(cor.test(x_y$x, x_y$y)$estimate, digits=5))
}

plot_anscombe(a1)
plot_anscombe(a2)
plot_anscombe(a3)
plot_anscombe(a4)

