#!/bin/bash
#SBATCH --account=priority-ethanlinck    #specify the account to use
#SBATCH --job-name=merqury_k21        # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                         # number of nodes to allocate
#SBATCH --ntasks-per-node=1               # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=48                 # number of cores to allocate
#SBATCH --mem=256G                          # 2000 MB of Memory allocated; set --mem with care
#SBATCH --time=0-20:00:00                 # Maximum job run time
#SBATCH --output=merqury_k21-%j.out
#SBATCH --error=merqury_k21-%j.err

module load Mamba/4.14.0-0
mamba activate nucifraga
awk '/^S/{print ">"$2;print $3}' n_columbiana_k21.asm.bp.p_ctg.gfa > n_columbiana_k21.asm.bp.p_ctg.fa
$MERQURY/merqury.sh /home/k14m234/nucifraga/jobs/n_columbiana_k21.meryl /home/k14m234/nucifraga/jobs/n_columbiana_k21.asm.bp.p_ctg.fa  nucifraga_k21

