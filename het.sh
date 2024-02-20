#!/bin/bash --login
###
#job name
#SBATCH --job-name=het
#job stdout file
#SBATCH --output=./het_out_%J
#job stderr file
#SBATCH --error=./het_err_%J
#maximum job time in D-HH:MM
#SBATCH --time=1-00:00
#number of nodes
#SBATCH --nodes=1
#number of parallel processes (tasks)
#SBATCH --ntasks=10
#memory in Gb 
#SBATCH --mem=50G
#set working directory
#SBATCH --chdir=.

#load modules used by the script 
module purge
module load angsd/0.935

# files to analyse
bam='/scratch/scw2141/hedgehog_bams/12u+X1417_15_eur_mEriEur2.1_13.04682.bam' # input bam
ref='/scratch/scw2141/hedgehog_bams/mEriEur2.1/GCA_950295315.1_mEriEur2.1_genomic.fa' # reference
auto='/scratch/scw2141/hedgehog_bams/mEriEur2.1/list_over_1mb.txt' # scaffolds


# depth variables
max=20
min=3

# estimate site allele frequency likelihood
angsd -i $bam -doSaf 1 -GL 1 -P 10 -anc $ref -rf $auto -out $bam -minMapQ 30 -minQ 30 -setMinDepthInd $min -setMaxDepthInd $max -doCounts 1

# get rid of any existing file
rm $bam.window.sfs

# loop through scaffolds and calculate sfs
cat $auto | while read line 
	do
		realSFS $bam.saf.idx -r $line -nSites 1000000 -P 10 >> $bam.window.sfs
	done



