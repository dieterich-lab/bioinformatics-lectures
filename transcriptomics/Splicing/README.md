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

All the core software that will be used in this part of the lecture is already available in the HPC cluster using the [environment modules](http://modules.sourceforge.net/). A [conda](https://docs.conda.io/projects/conda/en/latest/index.html) environment has been setup with additional packages. To perform the analyses below, you need to activate the environment as follows:


```bash
conda activate /biosw/bioinfo_2025_course/conda/transcriptomics
```

### Splicing workflow

#### Workflow in detail

1. Transcript-level abundance estimation with [Salmon](https://combine-lab.github.io/salmon/)
2. Perform differential transcript usage (DTU) with [DRIMSeq](https://www.bioconductor.org/packages/release/bioc/html/DRIMSeq.html)

All commands must be issued under the directory *bioinformatics-lectures/transcriptomics/Splicing* to work. Results will be written to a directory named *local*.

##### Transcript-level abundance estimation

**Note:** The first step is to generate the Salmon index, but this can take some time. To speed up the analysis, this has already been created. You should
thus first create the *local* directory, and copy the index

```bash
# assuming you are under $HOME/bioinformatics-lectures/transcriptomics/Splicing
mkdir -p local/salmon
ln -s /pub/bioinformatics-lectures/transcriptomics/Splicing/local/salmon/salmon_index local/salmon/salmon_index
```

We can then proceed with

```bash
snakemake --cores 10 all
```

Adapting `Snakemake` to a particular environment can entail many flags and options, and this is usually done using [configuration profiles](https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles). Profiles can also be used to specify resources to run jobs on a cluster. To keep things simple, and since we are using a small, downsampled dataset, we rely on a default, global profile, and are not submitting our jobs to the SLURM cluster middleware. This will also allow you to visualize interactively how `Snakemake` resolves the dependencies and create the required output.


##### Differential transcript usage

```bash
python -m ipykernel install --user --name="transcriptomics-python"
# start R-console
R
```

```R
install.packages('IRkernel')
IRkernel::installspec(name='R-practical', displayname='R-practical')
```

We also need to modify the kernel spec

```bash
jupyter kernelspec list
```

Use the R kernel created above, *e.g.* `~/.local/share/jupyter/kernels/r-practical/kernel.json`

```bash
# add this line to the R kernel spec
"env": {"R_LIBS":"/biosw/bioinfo_2025_course/0.0.1/rlib/"},
```

This should look like:

```json
{
  "argv": ["/biosw/bioinfo_2025_course/conda/transcriptomics/lib/R/bin/R", "--slave", "-e", "IRkernel::main()", "--args", "{connection_file}"],
  "env": {"R_LIBS":"/biosw/bioinfo_2025_course/0.0.1/rlib/"},
  "display_name": "R-practical",
  "language": "R"
}
```

