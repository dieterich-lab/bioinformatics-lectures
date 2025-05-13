# Introduction to bioinformatics

## Computational methods for alternative splicing analysis

### Description

Alternative splicing (AS) is an important process contributing to protein diversity. Regulation of splicing occurs through differential selection of splice sites, which results in variation in the abundance of isoforms and/or splicing events. Different splicing events can include exon skipping, alternative splice site usage, mutually exclusive exon usage, and intron retention. 

Several methods exist to perform differential analysis of splice junctions or differential junction usage (DJU); for an introduction and further references, the reader is referred to [Baltica: integrated splice junction usage analysis](https://dieterich-lab.github.io/Baltica/index.html).

This part of the practical contains material to perform differential transcript usage (DTU), *i.e.* the analysis of changes in the relative transcript abundance between different conditions, irrespective of a change in the overall expression of a gene, *i.e.* we are interested in transcript or isoform counts, rather than individual exons. For differential gene expression (DGE), see [RNAseq](../RNAseq/README.md).

The choice of the right analysis tool is usually non-trivial and depends on many factors. Here, we will use [DRIMSeq](https://www.bioconductor.org/packages/release/bioc/html/DRIMSeq.html). This section also aims to introduce the world of workflow managers, specifically [SnakeMake](https://github.com/snakemake/snakemake). 

Participants will gain experience and skills to be able to:

* Understand essential aspects of alternative splicing analysis, in particular differential transcript usage (DTU)
* Perform RNA-seq transcript level quantification using the Salmon software package
* Perform DTU analysis using DRIMSeq

### Dependencies

All the core software that will be used in this part of the lecture is already available in the HPC cluster using the [environment modules](http://modules.sourceforge.net/). A Python virtual environment has been setup with additional packages. A virtual environment is a tool to help you keep dependencies and packages required by different projects separate and isolated from the system-wide installation. To perform the analyses below, you need to activate the environment as follows:

```bash
# adjust year e.g. bioinfo_2025_course
source /biosw/bioinfo_2025_course/python/splicing/bin/activate
```

When you are done with this analysis, don't forget to "deactivate" the environment

```bash
deactivate
```

### Splicing workflow

#### Workflow in detail

1. Transcript-level abundance estimation with [Salmon](https://combine-lab.github.io/salmon/)
2. Perform differential transcript usage (DTU) with [DRIMSeq](https://www.bioconductor.org/packages/release/bioc/html/DRIMSeq.html)

All commands must be issued under the directory *bioinformatics-lectures/transcriptomics/Splicing* to work. Results will be written to a directory named *local*.

##### Transcript-level abundance estimation

Check [Snakefile](Snakefile). There are three rules, one to download the reference sequence, one to generate the Salmon index, and the last rule to perform transcript abundance quantification.

**Note:** Adapting `Snakemake` to a particular environment can entail many flags and options, and this is usually done using [configuration profiles](https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles). Profiles can also be used to specify resources to run jobs on a cluster. For this example, you need to update the SLURM profile under [profile/config.yaml](profile/config.yaml) with your actual `slurm_account:` value. Then run the following

```bash
# assuming you are under bioinformatics-lectures/transcriptomics/Splicing
snakemake --executor slurm --workflow-profile profile --printshellcmds --verbose &
```

##### Differential transcript usage

We will run the analysis directly on the console

```bash
./DRIMSeq_analysis.R
```

This will prepare the data for the analysis, run the statistical tests, and build the results tables: one table with a single p-value per gene, which tests whether there is any differential transcript usage within the gene, and one table with a single p-value per transcript, which tests whether the proportions for this transcript change within the gene. The script will also plot the estimated proportions for one of the significant genes, where we can see evidence of switching, and write the results to *local/dtu*.

Alternatively, you can run the analysis interactively, go to [https://r.internal](https://r.internal) and login using your LDAP credentials. **Use the latest R version.**

**Note:** To be able to run the analysis on RStudio Server, you need to update the search paths for packages.

```R
# adjust year e.g. bioinfo_2025_course
.libPaths <- .libPaths( c( .libPaths(), "/biosw/bioinfo_2025_course/0.0.1/rlib/") )
```

You can then set the working directory to the current directory, open the [script](DRIMSeq_analysis.R) on RStudio, and source from the GUI.

