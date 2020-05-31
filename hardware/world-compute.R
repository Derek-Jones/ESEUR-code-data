#
# world-compute.R, 22 May 20
#
# Data from:
# Supporting Online Material for: {The} World's Technological Capacity to Store, Communicate, and Compute Information
# Martin Hilbert and Priscila L{\'o}pez
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG computer_unit-sales

source("ESEUR_config.r")


par(mar=MAR_default+c(0.0, 0.7, 0, 0))

pal_col=rainbow(8)


# year,PC,Videogame_console,Mobile_phone/PDA,Server/mainframe,Supercomputer,Pocket_calculator,DSP,MCU,GPU
world_comp=read.csv(paste0(ESEUR_dir, "hardware/world-compute.csv.xz"), as.is=TRUE)

plot(1, type="n", log="y",
	xaxs="i",
	xlim=c(1985, 2008), ylim=c(1e1, max(world_comp)/1e6),
	xlab="Year", ylab="Unit sales (million)\n\n")

lines(world_comp$year, world_comp$GPU/1e6, type="b", col=pal_col[1])
lines(world_comp$year, world_comp$PC/1e6, type="b", col=pal_col[2])
lines(world_comp$year, world_comp$MCU/1e6, type="b", col=pal_col[3])
lines(world_comp$year, world_comp$DSP/1e6, type="b", col=pal_col[4])
lines(world_comp$year, world_comp$Videogame_console/1e6, type="b", col=pal_col[5])
lines(world_comp$year, world_comp$Mobile_phone.PDA/1e6, type="b", col=pal_col[6])
lines(world_comp$year, world_comp$Server.mainframe/1e6, type="b", col=pal_col[7])
lines(world_comp$year, world_comp$Pocket_calculator/1e6, type="b", col=pal_col[8])

legend(x="topleft", legend=c("GPU", "PC", "MCU", "DSP", "Videogame", "Modile phone/PDA", "Server/mainframe", "Pocket calculator"),
			inset=-c(0.03, 0.04), bty="n", fill=pal_col, cex=1.2)

