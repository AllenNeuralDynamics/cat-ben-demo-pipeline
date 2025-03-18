#!/usr/bin/env nextflow
// hash:sha256:4f62dd154a194341701284b56d1061ade5b95ad0ba55c9ffe253a4d62ca06b2f

nextflow.enable.dsl = 1

dynamicrouting_datacube_v0_0_265_to_dynamicrouting_encoding_io_1 = channel.fromPath("../data/dynamicrouting_datacube_v0.0.265/nwb", type: 'any', relative: true)
capsule_dynamicrouting_encoding_io_1_to_capsule_dynamicrouting_encoding_fit_2_2 = channel.create()
capsule_dynamicrouting_encoding_fit_2_to_capsule_dynamicrouting_encoding_fit_3_3 = channel.create()
capsule_dynamicrouting_encoding_io_1_to_capsule_dynamicrouting_encoding_fit_3_4 = channel.create()
capsule_dynamicrouting_encoding_fit_3_to_capsule_dynamicrouting_encoding_plot_4_5 = channel.create()
capsule_dynamicrouting_encoding_fit_2_to_capsule_dynamicrouting_encoding_plot_4_6 = channel.create()
capsule_dynamicrouting_encoding_plot_4_to_capsule_filter_pipeline_placeholder_files_5_7 = channel.create()
capsule_dynamicrouting_encoding_fit_3_to_capsule_filter_pipeline_placeholder_files_5_8 = channel.create()
capsule_dynamicrouting_encoding_fit_2_to_capsule_filter_pipeline_placeholder_files_5_9 = channel.create()

// capsule - dynamicrouting-encoding-io
process capsule_dynamicrouting_encoding_io_1 {
	tag 'capsule-4556585'
	container "$REGISTRY_HOST/capsule/cb87d42d-4ad6-4c23-9a90-6591d5dd0531:45a7854dbf63920bb0077282d528a7ac"

	cpus 4
	memory '32 GB'

	input:
	val path1 from dynamicrouting_datacube_v0_0_265_to_dynamicrouting_encoding_io_1

	output:
	path 'capsule/results/full/*' into capsule_dynamicrouting_encoding_io_1_to_capsule_dynamicrouting_encoding_fit_2_2
	path 'capsule/results/reduced/*' into capsule_dynamicrouting_encoding_io_1_to_capsule_dynamicrouting_encoding_fit_3_4

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=cb87d42d-4ad6-4c23-9a90-6591d5dd0531
	export CO_CPUS=4
	export CO_MEMORY=34359738368

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/dynamicrouting_datacube_v0.0.265/nwb" "capsule/data/nwb" # id: 45fc9444-71eb-4916-8673-2fba905985a0
	ln -s "/tmp/data/dynamicrouting_datacube_v0.0.265/session_table.parquet" "capsule/data/session_table.parquet" # id: 45fc9444-71eb-4916-8673-2fba905985a0
	ln -s "/tmp/data/dynamicrouting_datacube_v0.0.265/session_table.csv" "capsule/data/session_table.csv" # id: 45fc9444-71eb-4916-8673-2fba905985a0

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4556585.git" capsule-repo
	git -C capsule-repo checkout 2eb629af0ab6e8a0ad9fb4632f4c03d62f018e55 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_dynamicrouting_encoding_io_1_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - dynamicrouting-encoding-fit
process capsule_dynamicrouting_encoding_fit_2 {
	tag 'capsule-8024325'
	container "$REGISTRY_HOST/capsule/62e5b977-b823-422d-869f-53f6aa6528b2:cc4b81123ee9dee96a1c171eff0cdf72"

	cpus 4
	memory '32 GB'

	input:
	path 'capsule/data/' from capsule_dynamicrouting_encoding_io_1_to_capsule_dynamicrouting_encoding_fit_2_2.flatten()

	output:
	path 'capsule/results/outputs/*' into capsule_dynamicrouting_encoding_fit_2_to_capsule_dynamicrouting_encoding_fit_3_3
	path 'capsule/results/outputs/*' into capsule_dynamicrouting_encoding_fit_2_to_capsule_dynamicrouting_encoding_plot_4_6
	path 'capsule/results/outputs/*' into capsule_dynamicrouting_encoding_fit_2_to_capsule_filter_pipeline_placeholder_files_5_9

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=62e5b977-b823-422d-869f-53f6aa6528b2
	export CO_CPUS=4
	export CO_MEMORY=34359738368

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8024325.git" capsule-repo
	git -C capsule-repo checkout fec1f344e70f554f7b0eca575325c2d1b765c8ab --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_dynamicrouting_encoding_fit_2_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - dynamicrouting-encoding-fit
process capsule_dynamicrouting_encoding_fit_3 {
	tag 'capsule-8024325'
	container "$REGISTRY_HOST/capsule/62e5b977-b823-422d-869f-53f6aa6528b2:cc4b81123ee9dee96a1c171eff0cdf72"

	cpus 4
	memory '32 GB'

	input:
	path 'capsule/data/' from capsule_dynamicrouting_encoding_fit_2_to_capsule_dynamicrouting_encoding_fit_3_3.collect()
	path 'capsule/data/' from capsule_dynamicrouting_encoding_io_1_to_capsule_dynamicrouting_encoding_fit_3_4.flatten()

	output:
	path 'capsule/results/outputs/*' into capsule_dynamicrouting_encoding_fit_3_to_capsule_dynamicrouting_encoding_plot_4_5
	path 'capsule/results/outputs/*' into capsule_dynamicrouting_encoding_fit_3_to_capsule_filter_pipeline_placeholder_files_5_8

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=62e5b977-b823-422d-869f-53f6aa6528b2
	export CO_CPUS=4
	export CO_MEMORY=34359738368

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8024325.git" capsule-repo
	git -C capsule-repo checkout fec1f344e70f554f7b0eca575325c2d1b765c8ab --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_dynamicrouting_encoding_fit_3_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - dynamicrouting-encoding-plot
process capsule_dynamicrouting_encoding_plot_4 {
	tag 'capsule-8924646'
	container "$REGISTRY_HOST/capsule/0db4a11f-34ab-4c8c-b8cb-384e0af8c6b7:247f7a61917d90455bc5e86956cc69f0"

	cpus 1
	memory '8 GB'

	input:
	path 'capsule/data/outputs/' from capsule_dynamicrouting_encoding_fit_3_to_capsule_dynamicrouting_encoding_plot_4_5.collect()
	path 'capsule/data/outputs/' from capsule_dynamicrouting_encoding_fit_2_to_capsule_dynamicrouting_encoding_plot_4_6.collect()

	output:
	path 'capsule/results/counts.html' into capsule_dynamicrouting_encoding_plot_4_to_capsule_filter_pipeline_placeholder_files_5_7

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=0db4a11f-34ab-4c8c-b8cb-384e0af8c6b7
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8924646.git" capsule-repo
	git -C capsule-repo checkout 6c8cdefc0c0ed59b407bc710585823c6c1f26485 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - filter-pipeline-placeholder-files
process capsule_filter_pipeline_placeholder_files_5 {
	tag 'capsule-5612245'
	container "$REGISTRY_HOST/capsule/2040309f-59a7-4f6a-8ca2-00f426045b98:4a71b472a0099a61dae2362d0459ee2a"

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_dynamicrouting_encoding_plot_4_to_capsule_filter_pipeline_placeholder_files_5_7.collect()
	path 'capsule/data/outputs/' from capsule_dynamicrouting_encoding_fit_3_to_capsule_filter_pipeline_placeholder_files_5_8.collect()
	path 'capsule/data/outputs/' from capsule_dynamicrouting_encoding_fit_2_to_capsule_filter_pipeline_placeholder_files_5_9.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=2040309f-59a7-4f6a-8ca2-00f426045b98
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5612245.git" capsule-repo
	git -C capsule-repo checkout 3862d569fc492ca7aac08da72311230092658241 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}
