
library("libstableR")

pars <- c(1.5, 0.0, 1, 0)
       
# Generate an abscissas axis and probabilities vector
x = seq(-1, 1, 0.1)
       
# Calculate pdf, cdf and quantiles   
pdf = stable_pdf(x, pars)

