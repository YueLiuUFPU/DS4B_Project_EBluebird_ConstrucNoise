Website visualizing the csv is here:
https://barricklab.org/shiny/LTEE-Ecoli/

This file documents all the mutations occurred along the experimental evolution within each population compared to the original strain.

The data files have the following data:

LTEE-Ecoli-data 2022-10-13 14_17_57.csv:

treatment: always LTEE
population: from Ara-1to Ara-6, Ara+1 to Ara+6
time: which generation the sample was taken
strain: strain ID
clone: clone ID
mutator_status: when the strain is non-mutator, point-mutator or IS-mutation (Insertion-sequence-mediated mutations)
type: mutation types
start_position: relative position on the genome
end_position: relative position on the genome
gene_position: gene position on the genome
html_mutation: description of the mutation with symbols
html_mutation_annotation: description of the details of the mutation
gene_list: list of genes
gene_name: gene name
locus_tag: locus name on genbank
mutation_category:snp or deletion, insertion, inversion etc.
snp_type: synonymous or nonsynonymous