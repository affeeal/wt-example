.PHONY: clean generate build wt_example

clean:
	rm -rf ./build/

generate:
	cmake \
		-DCMAKE_BUILD_TYPE=Debug \
		-S . -B ./build/

silent-build:
	cmake --build ./build/

build:
	@make -s silent-build 

wt_example:
	./build/src/wt_example.wt \
		--docroot . --http-address 0.0.0.0 --http-port 9090
