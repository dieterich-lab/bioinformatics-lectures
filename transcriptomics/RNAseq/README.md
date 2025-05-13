# Introduction to bioinformatics

## From raw sequencing reads to differential expression

### Description

The first step always begins with identifying the experimental question or application, and establishing a suitable experimental design. We assume this has already been done. Our focus will be on the downstream computational workflow. This part of the practical contains material for the processing and analysis of the *RNA-seq* data from the example dataset.

Participants will gain experience and skills to be able to:

* Perform command-line analyses using an HPC cluster
* Assess the quality of RNA-seq data
* Pre-process (adapter removal, *etc.* ) and align RNA-seq data to a reference genome
* Perform differential expression analysis
* Understand the different file formats used in a standard RNA-seq workflow (FASTQ, FASTA, BAM, GTF, *etc.* )
* Understand essential aspects of alignment, abundance estimation, experimental design, *etc.*

**Note:** Aspects such as *(i)* library preparation and sequencing, or *(ii)* more advanced topics such as performing a reference guided or a *de novo* assembly of transcripts will NOT be covered in this introductory lecture.

### Dependencies

All the core software that will be used in this part of the lecture is already available in the HPC cluster using the [environment modules](http://modules.sourceforge.net/), and is loaded automatically when you login to the remote server.

### Data

The data for this part of the course is available under `/pub/raw-data`.


### RNA-seq workflow

RNA sequencing (RNA-seq) is used to interrogate in an unbiased manner the transcriptome, by quantifying RNA transcript abundance and diversity.
In this first part of the practical, we will go through a standard RNA-seq workflow using `Make`. `Make` is a build automation tool. 

**Note:** For this part of the course, you don't need to know more about makefiles or workflow managers! If you are interested in knowing more about `Make`, there are various tutorials available online, you can also consult the [GNU Make documentation](https://www.gnu.org/software/make/manual). You might also have heard about domain-specific language (DSL) workflow managers such as [Nextflow](https://www.nextflow.io) or [Snakemake](https://snakemake.readthedocs.io/en/stable). They can be used instead of `Make` to create reproducible and scalable data analyses. An example of a `Snakemake` workflow will be presented in the section of this practical dealing with [splicing](../Splicing/README.md).

The make utility requires a file called `Makefile` (or `makefile`), which defines a set of tasks to be executed. These tasks can be grouped into one or several rules, in the form of

```
target: prerequisites
<TAB> recipe
```

These rules allow to produce individual files. The target, prerequisites, and recipes together make a rule. 

#### Setup the working directory

The first step is to make the data available for the analysis. Go to *bioinformatics-lectures/transcriptomics/RNAseq/workflow* and 

```bash
make SYMLINK
```

This will create a directory named *local* and symlink the data for the analysis under *raw-data*. All commands must be issued
under the directory *bioinformatics-lectures/transcriptomics/RNAseq/workflow* to work.


#### Workflow in detail

1. Quality assessment with [MultiQC](https://multiqc.info/)
2. Removing sequencing adapters with [FlexBar](https://github.com/seqan/flexbar)
3. Removal of ribosomal RNA with  [bowtie2](https://github.com/BenLangmead/bowtie2)
4. Read mapping with  [STAR](https://github.com/alexdobin/STAR)
5. Read-to-gene assignment (abundance estimation, or read counting) with [subread/featurecount](http://subread.sourceforge.net/)

**Note:** The complete workflow, *i.e.* all rules can be called at once with `make all`, but we will call them one by one, and explain the different steps of the standard RNA-seq workflow. We will explore different aspects of this workflow using the following lessons: *(i)* [Quality assessment](lessons/quality_assessment.md), *(ii)* [Alignment](lessons/alignment.md), and finally *(iii)* [Read counting and DGE](lessons/dge.md).

