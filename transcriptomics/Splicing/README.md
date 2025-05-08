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

----

**TODO: UPDATE BELOW** 

### Dependencies

```bash
module load R
module load XXX

cd ~/hbigs_course_2022/part2_Splicing
python3 -m venv splicing
source splicing/bin/activate

pip3 install --upgrade pip setuptools wheel
pip install snakemake 
pip install jupyter
```

Start a R-Console
```bash
R
# register the kernel
IRkernel::installspec(name='ir4.1.1', displayname='R4.1')
```

We also need to modify the kernel spec
```
jupyter kernelspec list
```

Use the R kernel, *e.g.* `~/.local/share/jupyter/kernels/ir4.1.1/kernel.json`

```
# add this line to the R kernel spec
"env": {"R_LIBS":"/biosw/hbigs_course_2022_tbb/1.0.0/rlib"},
```

This should look like:

```
{
  "argv": ["/biosw/R/4.1.1_deb10/lib/R/bin/R", "--slave", "-e", "IRkernel::main()", "--args", "{connection_file}"],
  "env": {"R_LIBS":"/biosw/hbigs_course_2022_tbb/1.0.0/rlib"},
  "display_name": "R4.1",
  "language": "R"
}
```
