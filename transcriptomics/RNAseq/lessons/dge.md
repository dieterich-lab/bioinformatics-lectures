# Differential expression analysis

## Learning objectives:

* To perform abundance estimation with [subread/featurecount](http://subread.sourceforge.net/)
* To perform differential gene expression (DGE) analysis
* Understand essential statistical concepts used to model gene expression

## Gene-level abundance estimation (read counting)

```bash
make SUBREAD
```

Check [wrapper script](../workflow/subread_feature_counts.R).

## Differential gene expression (DGE) analysis

We will run the analysis directly on the console

```bash
./dge_analysis.R
```

Alternatively, you can run the analysis interactively, go to [https://r.internal](https://r.internal) and login using your LDAP credentials. **Use the latest R version.**

**Note:** To be able to run the analysis on RStudio Server, you need to update the search paths for packages.

```R
# adjust year e.g. bioinfo_2025_course
.libPaths <- .libPaths( c( .libPaths(), "/biosw/bioinfo_2025_course/0.0.1/rlib/") )
```

You can then set the working directory to the current directory, open the [script](../workflow/dge_analysis.R) on RStudio, and source from the GUI.

### Troubleshooting

If selected R packages are missing, these can be installed as follows:

```bash
# the R module is already loaded, else 
# module load R
# start R-console, or via RStudio
R
```

```R
# once in the R-console
install.packages("optparse")

if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Rsubread")
```

**Note:** If you install libraries for the first time in your account, you may be prompted with message similar to

```bash
Warning in install.packages("optparse") :
  'lib = "/beegfs/biosw/R/4.4.1_deb12/lib/R/library"' is not writable
Would you like to use a personal library instead? (yes/No/cancel) 
```

You can safely answer `yes` to these questions. The R packages will be installed locally in your `$HOME` directory.
After installing packages, to quit the R-console, just type `quit()`. You don't need to save your workspace.
