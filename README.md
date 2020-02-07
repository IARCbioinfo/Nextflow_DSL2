# Nextflow_DSL2
Repository with modules for nextflow DSL2. See https://www.nextflow.io/docs/edge/dsl2.html for help.

## BAM sorting
Module to sort all bam files from a folder using sambamba sort

Usage: 
```nextflow run Nextflow_DSL2/sorting.nf --input_folder bam --output_folder bam_sorted```

## VCF normalization
Module to normalize VCFs with bcftools. Expects a tab-separated values file with columns sample, tumor, normal.

Usage: 
```nextflow run Nextflow_DSL2/normalization.nf --vcf_folder bam --output_folder vcf_normalized --tn_file TN.tsv```
