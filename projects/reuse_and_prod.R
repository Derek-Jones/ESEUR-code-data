#
# reuse_and_prod.R,  9 Jul 16
#
# Data from:
# Reuse and productivity in integrated computer-aided software engineering: A
n empirical study
# Rajiv D. Banker and Robert J. Kauffman
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("betareg")


reuse=read.csv(paste0(ESEUR_dir, "projects/reuse_and_prod.csv.xz"), as.is=TRUE)

# reuse$unit_int=reuse$new_object/100-1e-9
# Beta distribution takes values in 0..1
reuse$unit_int=reuse$new_object/100

# One point at the upper limit has a huge leverage and results in
# a very different fit
reuse=subset(reuse, unit_int < 0.99)
reuse$l_func_pts=log(reuse$function.points)

plot_wide()

pal_col=rainbow(3)


plot(reuse$function.points, reuse$unit_int, log="x", col=point_col)

x_vals=seq(min(reuse$function.points), max(reuse$function.points), by=20)

# A quadratic fit has the new_object starting to increase again!
# re_mod=betareg(unit_int ~ l_func_pts+I(l_func_pts^2), data=reuse)
re_betamod=betareg(unit_int ~ l_func_pts, data=reuse)

b_pred=predict(re_betamod, newdata=data.frame(l_func_pts=log(x_vals)))

lines(x_vals, b_pred, col=pal_col[1])

re_mod=glm(unit_int ~ l_func_pts, data=reuse)

pred=predict(re_mod, newdata=data.frame(l_func_pts=log(x_vals)))

lines(x_vals, pred, col=pal_col[2])

