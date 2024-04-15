# *Nucifraga columbiana* genome assembly


## Files

epository for code and methods associated with *N. columbiana* genome assembly. 

`qc_output/`: folders with output from quality control programs (e.g. `merqury`, `quast`)

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

## Results

`Hifiasm` appears to have produced a larger and more contiguous assembly with default values. Here is a summary from `QUAST`:

| Assembly   				 | n_columbiana.asm.bp.p_ctg |
| ---------------------------| ------------------------- |
| # contigs (>= 0 bp)        | 1284                      |
| # contigs (>= 1000 bp)     | 1284                      |
| # contigs (>= 5000 bp)     | 1284                      |
| # contigs (>= 10000 bp)    | 1284                      |
| # contigs (>= 25000 bp)    | 1125                      |
| # contigs (>= 50000 bp)    | 562                       |
| Total length (>= 0 bp)     | 1327358016                |
| Total length (>= 1000 bp)  | 1327358016                |
| Total length (>= 5000 bp)  | 1327358016                |
| Total length (>= 10000 bp) | 1327358016                |
| Total length (>= 25000 bp) | 1323965263                |
| Total length (>= 50000 bp) | 1304414718                |
| # contigs                  | 1284                      |
| Largest contig             | 62260949                  |
| Total length               | 1327358016                |
| GC (%)                     | 44.35                     |
| N50                        | 21958091                  |
| N90                        | 1526686                   |
| auN                        | 23761111.7                |
| L50                        | 19                        |
| L90                        | 116                       |
| # N's per 100 kbp          | 0.00                      |

Compare that to results from an assembly with `-k 21` (as suggested by `merqury`):

|Assembly                    |n_columbiana_k21.asm.bp.p_ctg |
|----------------------------|------------------------------|
|# contigs (>= 0 bp)         |1318                          |
|# contigs (>= 1000 bp)      |1318                          |
|# contigs (>= 5000 bp)      |1318                          |
|# contigs (>= 10000 bp)     |1318                          |
|# contigs (>= 25000 bp)     |1171                          |
|# contigs (>= 50000 bp)     |609                           |
|Total length (>= 0 bp)      |1321622999                    |
|Total length (>= 1000 bp)   |1321622999                    |
|Total length (>= 5000 bp)   |1321622999                    |
|Total length (>= 10000 bp)  |1321622999                    |
|Total length (>= 25000 bp)  |1318500872                    |
|Total length (>= 50000 bp)  |1299103760                    |
|# contigs                   |1318                          |
|Largest contig              |62628041                      |
|Total length                |1321622999                    |
|GC (%)                      |44.34                         |
|N50                         |19279672                      |
|N90                         |1435525                       |
|auN                         |24336645.4                    |
|L50                         |19                            |
|L90                         |121                           |
|# N's per 100 kbp           |0.00    						|

(This assembly also took much longer to run.)

