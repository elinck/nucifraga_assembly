# *Nucifraga columbiana* genome assembly


## Files

epository for code and methods associated with *N. columbiana* genome assembly. 

`qc_output/`: files output from quality control programs (e.g. `merqury`, `quast`)

`sbatch': slurm scripts from the Tempest cluster

## Methods

University of Wyoming Museum of Vertebrates staff collected a nutcracker in Albany Country, WY in Autumn 2023, shipping whole heart, liver, and muscle tissue to Cantata Bio from DNA extraction and Pacbio HiFi sequencing. Raw reads were then transferred back to the Linck Lab at Montana State University for assembly of a draft genome before Hi-C sequencing to phase haplotypes and join contigs into scaffolds. Assembly procedures broadly followed procedures outlined in the [Vertebrate Genome Project](https://doi.org/10.1038/s41586-021-03451-0).

The draft genome was assembled using `hifiasm` v.0.19.5. An initial assembly was generated using default settings for HiFi only data, which include a *k*-mer value of 51: 

```
hifiasm -o n_columbiana_k20.asm -t 48 /home/k14m234/nucifraga/data/pacbio/XDOVE_20231115_R84050_PL4953-001_1-B01.hifi_reads.default.fastq.gz
```

A k-mer count database from raw reads was then built using `meryl` v.1.3 and the same *k*-mer value: 

```
meryl count k=51 /home/k14m234/nucifraga/data/pacbio/XDOVE_20231115_R84050_PL4953-001_1-B01.hifi_reads.default.fastq.gz output n_columbiana_k51.meryl
```

We used this to evaluate genome completeness and error rate using `merqury` v.1.3: 

```
$MERQURY/merqury.sh /home/k14m234/nucifraga/jobs/n_columbiana_k51.meryl /home/k14m234/nucifraga/jobs/n_columbiana.asm.bp.p_ctg.fa nucifraga
```

We also assessed genome contiguity with `QUAST` v.5.2.0: 

```
quast n_columbiana.asm.bp.p_ctg.fa

```

Next, we ran `merqury`'s best *k*-mer size script to chose a value for an alternate assembly, using a genome size value from `QUAST`: 

```
$MERQURY/best_k.sh 1327358016
```

We used the suggested output (rounded up to an odd value of `-k 21`) to run an alternate assembly with `hifiasm`: 

```
hifiasm -o n_columbiana_k20.asm -k 21 -t 48 
/home/k14m234/nucifraga/data/pacbio/XDOVE_20231115_R84050_PL4953-001_1-B01.hifi_reads.default.fastq.gz
```
