#
# cone-uncertainty.R, 30 Oct 11
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot_layout(2, 2)

cone.uncertainty=function(main_title="", accuracy=4, acc.improve=0, post.growth=0:100)
{
orig.accuracy=accuracy
total=100
forecast=NULL
for (i in 0:total)
   {
# How much have we already spent?
   ex.post=post.growth[i+1]
# Actual value can be between 1/accuracy and accuracy
   value.bounds=c(0, 1)*(accuracy - 1/accuracy) + 1/accuracy
# How much might we still have to spend?
   ex.ante=value.bounds*(total-ex.post)
   forecast=rbind(forecast, (ex.post+ex.ante)/100)
# Prediction accuracy might change as we work on project
   accuracy=accuracy*(1-acc.improve)
   }

plot(0:total, forecast[,1], type="l", main=main_title,
     xlim=c(0,100), ylim=c(1/orig.accuracy,orig.accuracy),
#     log="y")
     )
lines(0:total, forecast[,2])
}

cone.uncertainty("Uniform expenditure")
cone.uncertainty("Accuracy improves", acc.improve=0.01)

grow.1=c(0.5*(0:30), 15+1.5*(1:30), 60+1:40)
cone.uncertainty("Non-uniform expenditure", post.growth=grow.1)
cone.uncertainty("Accuracy improves", acc.improve=0.01, post.growth=grow.1)

