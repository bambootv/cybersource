.PHONY: all

dev: build run

build:
	docker build -t ruby_thin .

run:
	docker run -v `pwd`:/my_app -p 3001:3001 -it ruby_thin /bin/bash
