## Example slurm script showing how we estimate heterozygosity in angsd

edit the bam= argument to match you bamfile

I loop through each scaffold in the list individually, to get around the annoying issue of chimeric windows with end/beginning of different scaffolds

The short windows sampled at scaffold ends can be filtered out in R prior to plotting
