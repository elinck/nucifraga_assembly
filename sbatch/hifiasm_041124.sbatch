#!/bin/bash
#SBATCH --account=priority-ethanlinck    #specify the account to use
#SBATCH --job-name=nucifraga_hifiasm_k21        # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                         # number of nodes to allocate
#SBATCH --ntasks-per-node=1               # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=48                 # number of cores to allocate
#SBATCH --mem=256G                          # 2000 MB of Memory allocated; set --mem with care
#SBATCH --time=0-48:00:00                 # Maximum job run time
#SBATCH --output=nucifraga_hifiasm_k21-%j.out
#SBATCH --error=nucifraga_hifiasm_k21-%j.err
#SBATCH --mail-user=ethan.linck@montana.edu
#SBATCH --mail-type=ALL

module load hifiasm/0.19.5-GCCcore-11.2.0
hifiasm -o n_columbiana_k21.asm -k 21 -t 48 /home/k14m234/nucifraga/data/pacbio/XDOVE_20231115_R84050_PL4953-001_1-B01.hifi_reads.default.fastq.gz

