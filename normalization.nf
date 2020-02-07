nextflow.preview.dsl=2
params.filter_opt = "-f PASS "
params.cpu=2
params.mem=8

process normalization {
    cpus params.cpu
    memory params.mem+'GB'
    tag { vcf_tag }

    input:
    path vcf
    path fasta_ref
    path fasta_ref_fai

    output:
    path "${vcf_tag}_norm.vcf.gz*"

    shell:
    vcf_tag = vcf.baseName.replace(".gz","").replace(".vcf","")
    '''
    bcftools view !{params.filter_opt} -Ou !{vcf} | bcftools norm -f !{fasta_ref} -m - -Ou | bcftools sort -m !{params.mem}G -T sort_tmp/ -Ou | bcftools norm -d exact -Oz -o !{vcf_tag}_norm.vcf.gz
    tabix -p vcf !{vcf_tag}_norm.vcf.gz
    '''
}


workflow normalization_wf {
    get: input
    main: normalization(input)
}


workflow {
    main:
        data = Channel.fromPath( params.input_folder+'/*.vcf.gz')
        normalization(data,params.ref,params.ref+'.fai' )
    publish:
        normalization.out to: params.output_folder, mode: 'move'

}
