#
# world-compute.R,  9 Mar 16
#
# Data from:
# Supporting Online Material for: {The} World's Technological Capacity to Store, Communicate, and Compute Information
# Martin Hilbert and Priscila L{\'o}pez
# and
# The Postwar Evolution of Computer Prices
# Robert J. Gordon
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot_wide()
pal_col=rainbow(8)


# year,PC,Videogame_console,Mobile_phone/PDA,Server/mainframe,Supercomputer,Pocket_calculator,DSP,MCU,GPU
world_comp=read.csv(paste0(ESEUR_dir, "introduction/world-compute.csv.xz"), as.is=TRUE)

mmm_sales=read.csv(paste0(ESEUR_dir, "introduction/w2227.csv.xz"), as.is=TRUE)

plot(mmm_sales$year, mmm_sales$MF_units, type="l", log="y", col=pal_col[1],
	xlim=c(1955, 2008), ylim=c(100, max(world_comp)),
	xlab="Year", ylab="Unit sales\n")
lines(mmm_sales$year, mmm_sales$mini_units, col=pal_col[4])
text(1965, 2e4, "Mainframes", cex=1.3)
text(1980, 1e5, "Minicomputers", cex=1.3)


lines(world_comp$year, world_comp$GPU, type="b", col=pal_col[1])
lines(world_comp$year, world_comp$PC, type="b", col=pal_col[2])
lines(world_comp$year, world_comp$MCU, type="b", col=pal_col[3])
lines(world_comp$year, world_comp$DSP, type="b", col=pal_col[4])
lines(world_comp$year, world_comp$Videogame_console, type="b", col=pal_col[5])
lines(world_comp$year, world_comp$Mobile_phone.PDA, type="b", col=pal_col[6])
lines(world_comp$year, world_comp$Server.mainframe, type="b", col=pal_col[7])
lines(world_comp$year, world_comp$Pocket_calculator, type="b", col=pal_col[8])

legend(x="top", legend=c("GPU", "PC", "MCU", "DSP", "Videogame", "Modile phone/PDA", "Server/mainframe", "Pocket calculator"),
			bty="n", fill=pal_col, cex=1.2)

