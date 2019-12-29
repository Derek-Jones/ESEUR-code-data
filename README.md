
The code and data used to create the examples in "Evidence-based Software Engineering: based on the publicly available data" by Derek M. Jones.

[Plots of the data](http://www.knosof.co.uk/ESEUR/figures/index.html).

[Books' webpage](http://www.knosof.co.uk/ESEUR/index.html).

If you know of any software engineering data that you think should be included, please let me know.

To install all of the R library packages used by the code type:

  source("install.R")

at the R command line (if binaries are not available for your system, then they will be built from source and any dependencies will not automatically be detected).

All programs read the file: ESEUR_config.r.  Put a copy of this file in what R considers to be its home directory.

This file sets the variable ESEUR_dir to contain the base directory containing all the code+data.  The default value is R's home directory.

The .R files are a superset of what appear in the book.  If some data was analyzed and I thought it useful, but could not find a place for it in the book, it was put in a misc/ directory (some files may not have been moved).

The data has been compressed to stay under Github size limits and reduce download time.  You might find some filename strings are missing a .xz.

