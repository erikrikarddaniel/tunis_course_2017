# List of programs for Daniel's week of the Tunis course 2017

## Ubuntu packages

Modify the `/etc/apt/sources.list` to include:

```
deb https://<my.favorite.cran.mirror>/bin/linux/ubuntu <version/>
```

Change `<version/>` to the Ubuntu version (e.g. `xenial/`) and 
`<my.favourite.cran.mirror>` to something in:

https://cran.r-project.org/mirrors.html

Run these apt commands:

```
$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
$ sudo apt update
$ sudo apt install r-base git libjpeg62 libcurl4-gnutls-dev libxml2-dev libssl-dev mothur
```

For other Linux distributions, the appropriate packages need to be identified.

## RStudio

Download the lates (1.1.383) version from the [RStudio website](http://rstudio.org)
in an appropriate format and install.

## R packages

From inside R(Studio):

```R
> install.packages(c('tidyverse', 'vegan'))
> source("https://bioconductor.org/biocLite.R")
> biocLite("dada2")
> biocLite('phyloseq')
```
