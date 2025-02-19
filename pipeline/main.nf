#!/usr/bin/env nextflow
// hash:sha256:a209737e64c4e0c0d7db3043677b3d8194823cb40415f6aed164a257b9c3e6c7

nextflow.enable.dsl = 1

dynamicrouting_datacube_v0_0_261_to_dynamicrouting_encoding_io_1 = channel.fromPath("../data/dynamicrouting_datacube_v0.0.261/nwb/*", type: 'any', relative: true)
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
	container "$REGISTRY_HOST/capsule/cb87d42d-4ad6-4c23-9a90-6591d5dd0531:f7efabbc1e590236fcbad7d815ecea8a"

	cpus 1
	memory '8 GB'

	input:
	val path1 from dynamicrouting_datacube_v0_0_261_to_dynamicrouting_encoding_io_1

	output:
	path 'capsule/results/full/*' into capsule_dynamicrouting_encoding_io_1_to_capsule_dynamicrouting_encoding_fit_2_2
	path 'capsule/results/reduced/*' into capsule_dynamicrouting_encoding_io_1_to_capsule_dynamicrouting_encoding_fit_3_4

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=cb87d42d-4ad6-4c23-9a90-6591d5dd0531
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/dynamicrouting_datacube_v0.0.261/nwb/$path1" "capsule/data/$path1" # id: b59511ab-e888-4f96-8772-5627adc12e31
	ln -s "/tmp/data/dynamicrouting_datacube_v0.0.261/session_table.parquet" "capsule/data/session_table.parquet" # id: b59511ab-e888-4f96-8772-5627adc12e31
	ln -s "/tmp/data/dynamicrouting_datacube_v0.0.261/session_table.csv" "capsule/data/session_table.csv" # id: b59511ab-e888-4f96-8772-5627adc12e31

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4556585.git" capsule-repo
	git -C capsule-repo checkout 139afdf13ef5b9a8a2fbf92feccaa0fd8dbba772 --quiet
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
	container "$REGISTRY_HOST/capsule/62e5b977-b823-422d-869f-53f6aa6528b2:546ae21bd6bf1381f71ca068bea95711"

	cpus 1
	memory '8 GB'

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
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8024325.git" capsule-repo
	git -C capsule-repo checkout 668808b3933e4e272efdfdf3afb9e56d7176a8c1 --quiet
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
	container "$REGISTRY_HOST/capsule/62e5b977-b823-422d-869f-53f6aa6528b2:546ae21bd6bf1381f71ca068bea95711"

	cpus 1
	memory '8 GB'

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
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8024325.git" capsule-repo
	git -C capsule-repo checkout 668808b3933e4e272efdfdf3afb9e56d7176a8c1 --quiet
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
	git -C capsule-repo checkout c4133ae4039a66ea4640b41a7427e6f8c9bcc061 --quiet
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
