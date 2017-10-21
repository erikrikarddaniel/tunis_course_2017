# Tunis 2017 course: Instructions for how to set up a test computer

This document describes how to set up a computer so that prerequisites for
Daniel's practical can be tested. During the practical, students will perform
these steps themselves, so few programs need to be installed prior to the
course.

I have tested the instructions on a fresh Ubuntu 16.04.3 installation and I
provide install commands for that below.

## Preinstalled prerequisites

This section describes software I expect installed on all lab computers.

I assume a Linux computer with:

* Git

  $ sudo apt install git

* R 3.2.0 or higher (earlier version in the 3.x series might work, but I'm
  working on 3.2.3 so there's no guarantee)

  $ sudo apt install r-base

* Rstudio 1.1 (1.0 certainly works, but there are some nice new features in 1.1
  that makes it worth the trouble to install 1.1)

RStudio can be downloaded as a deb file from: www.rstudio.com. Choose the free
open source desktop version. (For Ubuntu, choose the deb with 16.04 in its
name.)

After downloading the deb, it can be installed like this:

  $ sudo apt install libjpeg62  # A prerequisite
  $ cd Downloads  # Or wherever the deb was downloaded
  $ sudo dpkg -i rstudio-xenial-1.1.383-amd64.deb  # Current name of deb

## What needs to be done test that computers can handle my practical

This section describes procedures that I intend students to perform themselves
as this forms part of becoming proficient in computational biology and is not
particularly difficult even for beginners.

### Install DADA2

Data in the form of 21 pairs of gzipped, subsampled fastq files. These will be
"cleaned" with DADA2, an R library that builds probabilistic models of errors in
sequences which can be applied to correct sequencing errors. DADA2 is an R
library and not command line tools, so it needs to be installed, see:

  https://bioconductor.org/packages/release/bioc/html/dada2.html

In short, first some Ubuntu prerequisites:

  $ sudo apt install libcurl4-gnutls-dev

Then, from the RStudio console (command line window inside RStudio):

  > source("https://bioconductor.org/biocLite.R")
  > biocLite("dada2")

### Install Daniel's wrapper scripts

I have written wrapper R scripts to make it easier to run DADA2 (this will be
one option during the practical, the other to follow instructions at the DADA2
web site). These can be downloaded from GitHub using the following commands
(note: the first three are only to organize things like I like it):

  $ cd ~
  $ mkdir dev
  $ cd dev
  $ git clone https://github.com/erikrikarddaniel/eemisdada2.git

I prefer to have all my github repos under a "dev" directory in my home
directory, but that's a matter of taste.

The wrapper scripts are in the src/R subdirectory of the repository. To make
sure they are runnable from the command line, *either* add this directory (the
src/R subdirectory of the repo) to your PATH (see below example) or create
symbolic links in a directory in your PATH, e.g. /usr/local/bin or ~/bin
(preferred).

Symbolic links in e.g. the bin directory of user's home directory are created
like this:

  $ cd ~/bin
  $ ln -s ../dev/eemisdada2/src/R/dada2* .

At least Ubuntu is normally set up so that if the ~/bin directory exists at
login time, the directory will be added to the PATH variable. To get this set,
the user thus has to login again, or, provided the terminal has been set to run
as a login shell (Profile preferences in the GNOME terminal)

To set the PATH variable to point directly to the Git repo:

  $ export PATH=$PATH:~/dev/eemisdada2/src/R

(If you use the PATH method, make sure to add the command to .bash_profile or
whatever initialization file you use.)

In the end, however you chose to set PATH to point to the scripts in my Git repo
the following command should reply with a line telling you where the scripts
are:

  $ which dada2bimeras

### Clone biomakefiles

I use "make" to automate program execution and have for this purpose written a
library of makefiles with useful recipes. This can also be cloned from my github
account:

  $ cd ~/dev
  $ git clone https://github.com/erikrikarddaniel/biomakefiles.git

### The data

When distributed, this WORK IN PROGRESS.
