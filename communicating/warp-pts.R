#
# warp-pts.R,  9 Apr 20
#
# Data from:
# Example
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example_fake-data


source("ESEUR_config.r")


library("RANN")


pal_col=rainbow(2)


check_prop=function(new_pts, is_x)
{
if (is_x)
   return(abs(myx_mean-stat_cond(new_pts)) < 0.01)
else
   return(abs(myy_mean-stat_cond(new_pts)) < 0.01)
}


# Randomly select points, return one that maintains desired
# statistical value.
mv_pts=function(pts)
{
repeat
   {
   new_x=pts$x+runif(num_pts, -0.01, 0.01)
   if (check_prop(new_x, TRUE))
      break()
   }

repeat
   {
   new_y=pts$y+runif(num_pts, -0.01, 0.01)
   if (check_prop(new_y, FALSE))
      break()
   }

return(data.frame(x=new_x, y=new_y))
}


# Randomly move a point, until the distance between src/tgt and reduced
mv_closer=function(pts)
{
repeat
   {
   new_pts=mv_pts(pts)
   new_dist=nn2(rabbit, new_pts, k=1)
   if (sum(new_dist$nn.dists) < cur_dist)
      {
      cur_dist <<- sum(new_dist$nn.dists)
      return(new_pts)
      }
   }

}


# Iterate over the points, moving src points closer to tgt points
# until there is very little left to do.
iter_closer=function(tgt_pts, src_pts)
{
# nn2 finds nearest neighbours
cur_dist <<- sum(nn2(tgt_pts, src_pts, k=1)$nn.dists)
cur_pts=src_pts
for (i in 1:5000)
   {
   new_pts=mv_closer(cur_pts)
   cur_pts=new_pts
   if (cur_dist < 13) # 13 runs in reasonable time; found by trial and error
      return(cur_pts)
   }
return(cur_pts)
}


warp_data=function(tgt_pts, src_pts, conditions)
{
num_pts <<- nrow(src_pts)
stat_cond <<- conditions # the statistical value we need to maintain

# The original statistical value we want to maintain
myx_mean <<- stat_cond(src_pts$x)
myy_mean <<- stat_cond(src_pts$y)

t=iter_closer(tgt_pts, src_pts)
return(t)
}


# Points forming a rabbit image
rabbit=read.csv(paste0(ESEUR_dir, "communicating/rabbit.csv.xz"), as.is=TRUE)

# Generate 250 random x/y points
my_data=data.frame(x=runif(250, min=-4, max=4), y=runif(250, min=-4, max=4))

# A brute force approach
t=warp_data(rabbit, my_data, mean)

# Original points
plot(my_data, col=pal_col[2])
# New points having same'ish statistical value as original points
points(t, col=pal_col[1])


# sd gets stuck in a loop.  I suspect that mv_points is the culprit
# t=warp_data(rabbit, my_data, sd)
# 
# plot(my_data, col="yellow")
# points(t, col=point_col)


