#
# world-compute.R,  6 Jul 17
#
# Data from:
# Supporting Online Material for: {The} World's Technological Capacity to Store, Communicate, and Compute Information
# Martin Hilbert and Priscila L{\'o}pez
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

pal_col=rainbow(8)


# year,PC,Videogame_console,Mobile_phone/PDA,Server/mainframe,Supercomputer,Pocket_calculator,DSP,MCU,GPU
world_comp=read.csv(paste0(ESEUR_dir, "hardware/world-compute.csv.xz"), as.is=TRUE)

plot(1, type="n", log="y",
	xlim=c(1985, 2008), ylim=c(1e6, max(world_comp)),
	xlab="Year", ylab="Unit sales\n")

lines(world_comp$year, world_comp$GPU, type="b", col=pal_col[1])
lines(world_comp$year, world_comp$PC, type="b", col=pal_col[2])
lines(world_comp$year, world_comp$MCU, type="b", col=pal_col[3])
lines(world_comp$year, world_comp$DSP, type="b", col=pal_col[4])
lines(world_comp$year, world_comp$Videogame_console, type="b", col=pal_col[5])
lines(world_comp$year, world_comp$Mobile_phone.PDA, type="b", col=pal_col[6])
lines(world_comp$year, world_comp$Server.mainframe, type="b", col=pal_col[7])
lines(world_comp$year, world_comp$Pocket_calculator, type="b", col=pal_col[8])

legend(x="topleft", legend=c("GPU", "PC", "MCU", "DSP", "Videogame", "Modile phone/PDA", "Server/mainframe", "Pocket calculator"),
			bty="n", fill=pal_col, cex=1.2)

