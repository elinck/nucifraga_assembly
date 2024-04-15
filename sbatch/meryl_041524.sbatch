#!/bin/bash
#SBATCH --account=priority-ethanlinck    #specify the account to use
#SBATCH --job-name=meryl_k21        # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                         # number of nodes to allocate
#SBATCH --ntasks-per-node=1               # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=48                 # number of cores to allocate
#SBATCH --mem=256G                          # 2000 MB of Memory allocated; set --mem with care
#SBATCH --time=0-20:00:00                 # Maximum job run time
#SBATCH --output=meryl_k21-%j.out
#SBATCH --error=meryl_k21-%j.err

module load Mamba/4.14.0-0
mamba activate nucifraga
meryl count k=21 /home/k14m234/nucifraga/data/pacbio/XDOVE_20231115_R84050_PL4953-001_1-B01.hifi_reads.default.fastq.gz output n_columbiana_k21.meryl

