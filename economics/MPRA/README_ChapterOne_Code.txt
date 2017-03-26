The code in this directory generates the tables and graphs in the first chapter "Variable marginal propensities to pirate and the diffusion of computer software" of "Waters, J. (2014). Four papers on the economics of technology. Unpublished PhD dissertation. Nottingham University Business School."

It is designed to run within the free R programming language.  The second line in each file (ie .libPaths("C:/Users/James/Documents/R/win-library/3.1")) will probably have to be changed, so that the C:... part refers to your preferred library path, if you have one.  Otherwise, omitting the whole line will result in the default library path being used.  The packages MASS and numDeriv are required.

The eighth line (currdir<-"C:\\ChapterOne_Code\\") will also have to be changed, so that the C:... part refers to the directory where you have saved the files.  Double back slashes have to separate the path elements.

The code can then be used.  The end output is the table column or graph referenced by the file name.