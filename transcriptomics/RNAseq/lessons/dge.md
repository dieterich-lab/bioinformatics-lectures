# Differential expression analysis

## Learning objectives:

* To perform abundance estimation with [subread/featurecount](http://subread.sourceforge.net/)
* To perform differential gene expression (DGE) analysis
* Understand essential statistical concepts used to model gene expression

## Gene-level abundance estimation (read counting)

```bash
make SUBREAD
```

Check [wrapper script](subread_feature_counts.R).

## Differential gene expression (DGE) analysis

We will run the analysis directly on the console

```bash
./dge_analysis.R
```

Alternatively, you can run the analysis interactively, go to [https://r.internal](https://r.internal) and login using your LDAP credentials. **Use the latest R version.**

**Note:** To be able to run the analysis on RStudio Server, you need to update the search paths for packages.

```R
.libPaths <- .libPaths( c( .libPaths(), "/biosw/bioinfo_2025_course/0.0.1/rlib/") )
```

You can then set the working directory to the current directory, open the [script](dge_analysis.R) on RStudio, and source from the GUI.
