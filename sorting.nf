nextflow.preview.dsl=2
params.cpu=20
params.mem=40

process sort_bam {
    cpus params.cpu
	memory params.mem+'G'
    input:
        path bam
    output:
      path "${file_tag}_sorted.bam*"
    shell:
    file_tag = bam.baseName
    '''
    sambamba sort -t !{params.cpu} -m !{params.mem}G --tmpdir=sort_tmp -o !{file_tag}_sorted.bam !{bam}
    '''
}

workflow sorting_wf {
    take: input
    main: sort_bam(input)
}


workflow {
    main:
        data = Channel.fromPath( params.input_folder+'/*.bam')
        sort_bam(data)
    publish:
        sort_bam.out to: params.output_folder, mode: 'move'
}
