cn := etlegacy-server
runargs := --rm -ti -v $$PWD:/data -p 1181:80 --env-file=config

build:
	docker build $(buildargs) -t $(cn) .

run: build
	docker run $(runargs) $(cn)


.PHONY: build run
