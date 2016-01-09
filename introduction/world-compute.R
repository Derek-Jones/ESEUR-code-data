#
# world-compute.R,  5 Jan 16
#
# Data from:
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# year,PC,Videogame_console,Mobile_phone/PDA,Server/mainframe,Supercomputer,Pocket_calculator,DSP,MCU,GPU
world_comp=read.csv(paste0(ESEUR_dir, "introduction/world-compute.csv.xz"), as.is=TRUE)

pal_col=rainbow(8)

plot(world_comp$year, world_comp$GPU, type="l", log="y", col=pal_col[1],
	ylim=c(1e7, max(world_comp)),
	xlab="Year", ylab="Sales volume\n")

lines(world_comp$year, world_comp$PC, col=pal_col[2])
lines(world_comp$year, world_comp$MCU, col=pal_col[3])
lines(world_comp$year, world_comp$DSP, col=pal_col[4])
lines(world_comp$year, world_comp$Videogame_console, col=pal_col[5])
lines(world_comp$year, world_comp$Mobile_phone.PDA, col=pal_col[6])
lines(world_comp$year, world_comp$Server.mainframe, col=pal_col[7])
lines(world_comp$year, world_comp$Pocket_calculator, col=pal_col[8])

legend(x="topleft", legend=c("GPU", "PC", "MCU", "DSP", "Videogame", "Modile phone/PDA", "Server/mainframe", "Pocket calculator"),
			bty="n", fill=pal_col, cex=1.3)

