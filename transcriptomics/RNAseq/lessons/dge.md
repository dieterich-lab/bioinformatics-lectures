# Differential expression analysis

## Learning objectives:

* To perform abundance estimation with [**subread/featurecount**](http://subread.sourceforge.net/)
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

Alternatively, you can open the [script](dge_analysis.R) on RStudio, modify the input/output directories, 
and run the script. For running the analysis interactively, go to [https://r.internal](https://r.internal) and login using your LDAP credentials.
