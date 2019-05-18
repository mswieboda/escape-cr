default: build_and_run

build_exec:
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build src/geo.cr -o build/geo

build_exec_release:
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build --release src/geo.cr -o build/geo_release

build_and_run: build_exec run

build_release_and_run: build_exec_release run_release

run:
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/geo

run_release:
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/geo_release
