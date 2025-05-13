# Introduction to bioinformatics

## Ribo-seq data analysis

### Description

This part of the practical contains material for the processing and analysis of the *Ribo-seq* data from the example dataset.
The content of the lecture is described below in more detail with learning objectives. We will cover aspects of each section by means of
[Jupyter notebooks](https://jupyter.org/). 

### Dependencies

All the core software that will be used in this part of the lecture is already available on the HPC cluster. A [conda](https://docs.conda.io/projects/conda/en/latest/index.html) environment has been setup with all required packages. To perform the analyses for this part of the practical, you will need to activate the environment as follows:

```bash
# adjust year e.g. bioinfo_2025_course
conda activate /biosw/bioinfo_2025_course/conda/transcriptomics
```

We will *run* the notebooks on our JupyterHub Server, which provides an access to our computational environments and resources. You will need to create a *kernel spec* to use this environment with the notebooks. To do so

```bash
python -m ipykernel install --user --name="transcriptomics-python"
```

Finally, go to [https://jupyter.internal](https://jupyter.internal) and login using your LDAP credentials. Use the *File Browser* to navigate to *bioinformatics-lectures/transcriptomics/Riboseq*, and open the first notebook, dedicated to [riboseq_analysis](riboseq_analysis.ipynb). Select the kernel *transcriptomics-python* that we just created. You will normally be prompted to choose a kernel when opening a notebook for the first time. To force change kernel, either go to *Kernel > Change kernel...* in the top menu bar, or use the shortcut *Switch kernel* on the top right. 

    
### Introduction to Ribo-seq data analysis

#### Sections:
    1.1 Short introduction to Jupyter (Notebook) and the JupyterHub
    1.2 Overview of the rpbp pipeline: command line options and configuration file
    1.3 High-level introduction to Ribo-seq, de novo ORF discovery (elements of annotation, transcript isoforms, CDS, UTRs, etc.), biological relevance of alternative translation events (including translation from non-coding transcripts), and why we need "dedicated software" to analyse Ribo-seq data.
    1.4 Ribo-seq quality control how-to.

#### Questions & Objectives:
    - Jupyter Notebook basics: dashboard, user interface, navigation, running code, etc. How to use Jupyter with virtual environments.
    - How to use the JupyterHub.
    - What is the translatome? What are the uses of Ribo-seq.
    - Why do we need dedicated software to analyse Ribo-seq data? What softwares are available to analyse Ribo-seq data?
    - Run one such software, rpbp, on a selected Ribo-seq dataset.
    - Learn how to identify "good quality" Ribo-seq data.
    - Learn how to visualise the results.

#### After I will be able to:
    - Understand what is a Jupyter Notebook, and how to use it.
    - Understand how to analyse Ribo-seq data for ORF discovery.
    - Use the ORF predictions for follow-up studies.

    
