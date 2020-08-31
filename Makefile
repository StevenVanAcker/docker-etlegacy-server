cn := etlegacy-server
runargs := --rm -ti -v $$PWD:/data

build:
	docker build $(buildargs) -t $(cn) .

run: build
	docker run $(runargs) $(cn) /bin/bash


.PHONY: build run
