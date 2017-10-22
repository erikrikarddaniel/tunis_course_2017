# Tunis 2017 course: Instructions for how to set up a test computer

This document describes how to set up a computer so that prerequisites for
Daniel's practical can be tested. During the practical, students will perform
these steps themselves, so few programs need to be installed prior to the
course.

I have tested the instructions on a fresh Ubuntu 16.04.3 installation running
on a virtual machine with 4 GiB RAM and 200 GiB disk. I provide install commands
for that below.

## Preinstalled prerequisites

This section describes software I expect installed on all lab computers.

I assume a Linux computer with:

* Git

```bash
$ sudo apt install git
```

* R 3.4.2 or higher (I think at least 3.3 series is required
  working on 3.4.2 so there's no guarantee)
  
To get the latest R as a Ubuntu package, you need to add a line like this to
your `/etc/apt/sources.list`:

```
deb https://<my.favorite.cran.mirror>/bin/linux/ubuntu xenial/
```

You need to change `<my.favorit.cran.mirror>` for a mirror near you, there's a list here:

https://cran.r-project.org/mirrors.html

After adding that line, you should add the public key of the developer who signs
packages to avoid warning messages:

```bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
```

After you've done all this, you can install after and `apt update`:

```bash
$ sudo apt update && sudo apt install r-base
```

* Rstudio 1.1 (1.0 certainly works, but there are some nice new features in 1.1
  that makes it worth the trouble to install 1.1)

RStudio can be downloaded as a deb file from: www.rstudio.com. Choose the free
open source desktop version. (For Ubuntu, choose the deb with 16.04 in its
name.)

After downloading the deb, it can be installed like this:

```bash
$ sudo apt install libjpeg62  # A prerequisite
$ cd Downloads  # Or wherever the deb was downloaded
$ sudo dpkg -i rstudio-xenial-1.1.383-amd64.deb  # Current name of deb
```

## What needs to be done to test that computers can handle my practical

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

```bash
$ sudo apt install libcurl4-gnutls-dev
```

Then, from the RStudio console (command line window inside RStudio):

```R
> source("https://bioconductor.org/biocLite.R")
> biocLite("dada2")
```

### Install Daniel's wrapper scripts

I have written wrapper R scripts to make it easier to run DADA2 (this will be
one option during the practical, the other to follow instructions at the DADA2
web site). These can be downloaded from GitHub using the following commands
(note: the first three are only to organize things like I like it):

```bash
$ cd ~
$ mkdir dev
$ cd dev
$ git clone https://github.com/erikrikarddaniel/eemisdada2.git
```

I prefer to have all my github repos under a "dev" directory in my home
directory, but that's a matter of taste.

The wrapper scripts are in the src/R subdirectory of the repository. To make
sure they are runnable from the command line, *either* add this directory (the
src/R subdirectory of the repo) to your PATH (see below example) or create
symbolic links in a directory in your PATH, e.g. /usr/local/bin or ~/bin
(preferred).

Symbolic links in e.g. the bin directory of user's home directory are created
like this:

```
$ cd ~/bin
$ ln -s ../dev/eemisdada2/src/R/dada2* .
```

At least Ubuntu is normally set up so that if the ~/bin directory exists at
login time, the directory will be added to the PATH variable. To get this set,
the user thus has to login again, or, provided the terminal has been set to run
as a login shell (Profile preferences in the GNOME terminal)

To set the PATH variable to point directly to the Git repo:

```bash
$ export PATH=$PATH:~/dev/eemisdada2/src/R
```

(If you use the PATH method, make sure to add the command to .bash_profile or
whatever initialization file you use.)

In the end, however you chose to set PATH to point to the scripts in my Git repo
the following command should reply with a line telling you where the scripts
are:

```
$ which dada2bimeras
```

The scripts uses a couple of R libraries that must be installed from R, before that
a Ubuntu package needs to be installed:

```bash
$ sudo apt install libxml2-dev libssl-dev
```

Now, the packages can be installed from inside R, e.g. the RStudio console:

```R
> install.packages(c('optparse', 'tidyverse'))
```

(The "tidyverse" is a meta package containing all libraries from the Tidyverse,
most importanly dplyr, tidyr and readr. We will be using these *a lot* during
the practical.)

Check that the scripts work and that all prerequisites are installed and found:

```bash
$ dada2bimeras --version
$ dada2cleanNmerge --version
$ dada2errmodels --version
$ dada2filter --version
```

Each command should return a string saying the version of the script (1.0 at the
time of writing) and DADA2 (1.4.0).

### Clone biomakefiles

I use "make" to automate program execution and have for this purpose written a
library of makefiles with useful recipes. This can also be cloned from my github
account:

```bash
$ cd ~/dev
$ git clone https://github.com/erikrikarddaniel/biomakefiles.git
```

### The data

The data itself will be downloaded from a separately distributed URL. As a help 
in setting up everything for testing you can clone *this* repository, i.e. the
repository this documentation belongs to. I always have my projects under a directory
called `projects`, I assume that you do the same here.

```bash
$ mkdir ~/projects
$ cd ~/projects
$ git clone https://github.com/erikrikarddaniel/tunis_course_2017.git
```

After this, `cd` into the `samples` directory of the git repo and download and
unpack the data tar ball there.

```bash
$ cd samples
$ wget *url*/tunis_course_2017.tar
$ tar xf tunis_course_2017.tar
```

### `screen`

At this stage I'm going to introduce the [screen program](https://www.gnu.org/software/screen/manual/screen.html)
to the students. It's a very useful tool for three major reasons:

1. It's a command line "window manager" that lets you have easy access to several
windowns each for a certain purpose and positioned in the correct directory. This
way you don't need to `cd` (or `pushd`/`popd`) between directories and tasks.

2. It lets you disconnect from a server and keep a command running. In this way it
replaces `nohup` but is far more sophisticated and you don't need to remember to
place `nohup` in front of every command.

3. You can connect and disconnect to a running screen session from different computers
allowing you to continue working when you get home (and never have any free time! ;-)).

In the root directory of the project git repo there's a configuration file for screen
which you can run like this:

```bash
$ screen -c .screenrc
```

Commands in screen are preceded with a `<ctrl>-a` and I will sprinkle code
examples below with that. If you choose not to use screen, just ignore those commands
and do the corresponding `cd` or whatever is required.

### Running the dada2 workflow

The dada2 workflow will be run from the `dada2` directory. If you cloned this 
repository you will already have a directory with symbolic links pointing to the
data files in the `samples` directory. Move to the `dada2` directory in screen
by pressing `<ctrl>-a'dada2` or `<ctrl>-a"` and selecting `dada2` from the list,
and check that the symbolic links are there and functional.

1. Create a symbolic link to the biomakefiles repository in the root of the project
directory structure (screen: `<ctrl>-a'root`):

```bash
$ ln -s ../../dev/biomakefiles
```

2. Back in the `dada2` directory (screen: `<ctrl>-a'dada2`), create a file called 
`Makefile` with just a single line:

```make
include ../biomakefiles/lib/make/makefile.dada2
```

3. Run dada2. Each of the commands below will take some time, so type in one, wait
until it finishes and then start the next. It doesn't hurt to check status by
echoing `$?` like I do below, and take action if it's &gt;1. Also check that output
files do not indicate errors: `dada2filter.out`, `dada2errmodels.out`, *WORK IN PROGRESS*.

```bash
$ make -n dada2filter.out  # Shows what will be done, doesn't start
$ make dada2filter.out  # Runs the command
$ echo $?  # Shows exit status, should be <2
$ make -n dada2errmodels.out
$ make dada2errmodels.out  # DOESN'T work at the moment, CHECKING this
$ echo $?
```

