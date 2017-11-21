include ../../biomakefiles/lib/make/makefile.clustalo

CLUSTALO_OPTS = 

all_eukaryotic_alignments: $(subst .faa,.eukaryotes.co.alnfaa,$(wildcard Nrd?.faa))

%.eukaryotes.faa: %.faa
	grep -A 1 'Eukaryota' $< | grep -v '^--$$' > $@
