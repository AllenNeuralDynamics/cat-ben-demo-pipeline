#!/usr/bin/env nextflow
// hash:sha256:273f30887621c30771f8b717a1b2a29654ffb5c92c11516bc3028848e60d2315

nextflow.enable.dsl = 1

dynamicrouting_datacube_v0_0_261_to_dynamicrouting_encoding_io_1 = channel.fromPath("../data/dynamicrouting_datacube_v0.0.261/nwb", type: 'any', relative: true)

// capsule - dynamicrouting-encoding-io
process capsule_dynamicrouting_encoding_io_1 {
	tag 'capsule-9348254'
	container "$REGISTRY_HOST/capsule/82c400eb-a0b8-45b4-abce-43db82b77478:95b2a8c7192a5e2a894b5703fc8c8d57"

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	val path1 from dynamicrouting_datacube_v0_0_261_to_dynamicrouting_encoding_io_1

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=82c400eb-a0b8-45b4-abce-43db82b77478
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/dynamicrouting_datacube_v0.0.261/nwb" "capsule/data/nwb" # id: b59511ab-e888-4f96-8772-5627adc12e31
	ln -s "/tmp/data/dynamicrouting_datacube_v0.0.261/session_table.parquet" "capsule/data/session_table.parquet" # id: b59511ab-e888-4f96-8772-5627adc12e31
	ln -s "/tmp/data/dynamicrouting_datacube_v0.0.261/session_table.csv" "capsule/data/session_table.csv" # id: b59511ab-e888-4f96-8772-5627adc12e31

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9348254.git" capsule-repo
	git -C capsule-repo checkout 7b4c43f0aa248a4970ce1b64244b70972a99a759 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_dynamicrouting_encoding_io_1_args}

	echo "[${task.tag}] completed!"
	"""
}
