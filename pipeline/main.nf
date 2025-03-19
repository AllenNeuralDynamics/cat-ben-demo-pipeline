#!/usr/bin/env nextflow
// hash:sha256:c15c67ea0d3ab320cbaf625af78d4c956dff2e44b5d1d088c43560f94223174c

nextflow.enable.dsl = 1

dynamicrouting_datacube_v0_0_265_to_cat_demo_param_dispatch_1 = channel.fromPath("../data/dynamicrouting_datacube_v0.0.265/nwb/*", type: 'any', relative: true)
capsule_cat_demo_param_dispatch_1_to_capsule_cat_demo_processing_2_2 = channel.create()
capsule_cat_demo_processing_2_to_capsule_filter_pipeline_placeholder_files_5_3 = channel.create()

// capsule - cat-demo-param-dispatch
process capsule_cat_demo_param_dispatch_1 {
	tag 'capsule-8803024'
	container "$REGISTRY_HOST/capsule/a6567731-a2d4-41ff-bb97-d5e6799c2c4b"

	cpus 1
	memory '4 GB'

	input:
	val path1 from dynamicrouting_datacube_v0_0_265_to_cat_demo_param_dispatch_1

	output:
	path 'capsule/results/*' into capsule_cat_demo_param_dispatch_1_to_capsule_cat_demo_processing_2_2

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=a6567731-a2d4-41ff-bb97-d5e6799c2c4b
	export CO_CPUS=1
	export CO_MEMORY=4294967296

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/dynamicrouting_datacube_v0.0.265/nwb/$path1" "capsule/data/$path1" # id: 45fc9444-71eb-4916-8673-2fba905985a0
	ln -s "/tmp/data/dynamicrouting_datacube_v0.0.265/consolidated" "capsule/data/consolidated" # id: 45fc9444-71eb-4916-8673-2fba905985a0

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8803024.git" capsule-repo
	git -C capsule-repo checkout ede5707dfdaf9a43cdb58ed47137db0862cbb179 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_cat_demo_param_dispatch_1_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - cat-demo-processing
process capsule_cat_demo_processing_2 {
	tag 'capsule-0173797'
	container "$REGISTRY_HOST/capsule/0cd660e2-b9da-466c-a498-26cc0736f4d9"

	cpus 1
	memory '4 GB'

	input:
	path 'capsule/data/' from capsule_cat_demo_param_dispatch_1_to_capsule_cat_demo_processing_2_2.flatten()

	output:
	path 'capsule/results/outputs/*' into capsule_cat_demo_processing_2_to_capsule_filter_pipeline_placeholder_files_5_3

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=0cd660e2-b9da-466c-a498-26cc0736f4d9
	export CO_CPUS=1
	export CO_MEMORY=4294967296

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0173797.git" capsule-repo
	git -C capsule-repo checkout 33906a009874c8798885f50bb68d6031c5a24b18 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_cat_demo_processing_2_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - filter-pipeline-placeholder-files
process capsule_filter_pipeline_placeholder_files_5 {
	tag 'capsule-5612245'
	container "$REGISTRY_HOST/capsule/2040309f-59a7-4f6a-8ca2-00f426045b98"

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/outputs/' from capsule_cat_demo_processing_2_to_capsule_filter_pipeline_placeholder_files_5_3.collect()

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
