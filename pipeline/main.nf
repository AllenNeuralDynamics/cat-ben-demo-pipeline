#!/usr/bin/env nextflow
// hash:sha256:69d765701b683456559355c39614b125eb4713cf804c7cd45777f52a064b9e0d

nextflow.enable.dsl = 1

dynamicrouting_datacube_v0_0_261_to_dynamicrouting_encoding_io_1 = channel.fromPath("../data/dynamicrouting_datacube_v0.0.261/nwb/*", type: 'any', relative: true)
capsule_dynamicrouting_encoding_io_1_to_capsule_dynamicrouting_encoding_fit_2_2 = channel.create()
capsule_dynamicrouting_encoding_fit_2_to_capsule_dynamicrouting_encoding_fit_3_3 = channel.create()
capsule_dynamicrouting_encoding_io_1_to_capsule_dynamicrouting_encoding_fit_3_4 = channel.create()
capsule_dynamicrouting_encoding_fit_2_to_capsule_dynamicrouting_encoding_plot_4_5 = channel.create()
capsule_dynamicrouting_encoding_fit_3_to_capsule_dynamicrouting_encoding_plot_4_6 = channel.create()

// capsule - dynamicrouting-encoding-io
process capsule_dynamicrouting_encoding_io_1 {
	tag 'capsule-9348254'
	container "$REGISTRY_HOST/capsule/82c400eb-a0b8-45b4-abce-43db82b77478:95b2a8c7192a5e2a894b5703fc8c8d57"

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

	export CO_CAPSULE_ID=82c400eb-a0b8-45b4-abce-43db82b77478
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
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9348254.git" capsule-repo
	git -C capsule-repo checkout 2e4b4b1d7cf8ff99c490a7cff965a9a9710443d6 --quiet
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
	tag 'capsule-5184476'
	container "$REGISTRY_HOST/capsule/3f98e032-f938-4959-8577-a28f814dd973:95b2a8c7192a5e2a894b5703fc8c8d57"

	cpus 1
	memory '8 GB'

	input:
	path 'capsule/data/' from capsule_dynamicrouting_encoding_io_1_to_capsule_dynamicrouting_encoding_fit_2_2.flatten()

	output:
	path 'capsule/results/outputs/*' into capsule_dynamicrouting_encoding_fit_2_to_capsule_dynamicrouting_encoding_fit_3_3
	path 'capsule/results/outputs/*' into capsule_dynamicrouting_encoding_fit_2_to_capsule_dynamicrouting_encoding_plot_4_5

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=3f98e032-f938-4959-8577-a28f814dd973
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5184476.git" capsule-repo
	git -C capsule-repo checkout b0b6ff8f0399bf9d59a8da8a0aa4c70d38b29f52 --quiet
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
	tag 'capsule-5184476'
	container "$REGISTRY_HOST/capsule/3f98e032-f938-4959-8577-a28f814dd973:95b2a8c7192a5e2a894b5703fc8c8d57"

	cpus 1
	memory '8 GB'

	input:
	path 'capsule/data/' from capsule_dynamicrouting_encoding_fit_2_to_capsule_dynamicrouting_encoding_fit_3_3
	path 'capsule/data/' from capsule_dynamicrouting_encoding_io_1_to_capsule_dynamicrouting_encoding_fit_3_4.flatten()

	output:
	path 'capsule/results/outputs/*' into capsule_dynamicrouting_encoding_fit_3_to_capsule_dynamicrouting_encoding_plot_4_6

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=3f98e032-f938-4959-8577-a28f814dd973
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5184476.git" capsule-repo
	git -C capsule-repo checkout b0b6ff8f0399bf9d59a8da8a0aa4c70d38b29f52 --quiet
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

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/full/' from capsule_dynamicrouting_encoding_fit_2_to_capsule_dynamicrouting_encoding_plot_4_5.collect()
	path 'capsule/data/reduced/' from capsule_dynamicrouting_encoding_fit_3_to_capsule_dynamicrouting_encoding_plot_4_6.collect()

	output:
	path 'capsule/results/*'

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
