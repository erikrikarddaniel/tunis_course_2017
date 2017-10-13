#!/bin/sh

# Copys and subsets data from J.Pinhassi_17_02-P8309

for f in $(ls /proj/b2011200/nobackup/projects/LMO/sequencing/J.Pinhassi_17_02-P8309/samples/*.fastq.gz | grep '3-0.2'); do
  gunzip -c $f | head -n 40000 | gzip -c > $(basename $f)
done
