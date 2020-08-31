cn := etlegacy-server
runargs := --rm -ti -v $$PWD:/data -p 11180:80 -p 27960:27960/udp --env-file=config

build:
	docker build $(buildargs) -t $(cn) .

run: build
	docker run $(runargs) $(cn)


.PHONY: build run
