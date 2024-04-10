#!/bin/bash
#SBATCH --account=priority-ethanlinck    #specify the account to use
#SBATCH --job-name=nucifraga_hifiasm_default        # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                         # number of nodes to allocate
#SBATCH --ntasks-per-node=1               # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=4                 # number of cores to allocate
#SBATCH --mem=48G                          # 2000 MB of Memory allocated; set --mem with care
#SBATCH --time=0-20:00:00                 # Maximum job run time
#SBATCH --output=quast_default-%j.out
#SBATCH --error=quast_default-%j.err

module load Mamba/4.14.0-0
mamba activate quast
quast n_columbiana.asm.bp.p_ctg.fa

