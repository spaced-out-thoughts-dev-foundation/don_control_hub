VERSION ?= latest
run:
	docker run  -p 4567:4567 --restart=always -d --name don_central_hub awkwardsandwich7/don_central_hub:${VERSION}

push-image:
	./push_to_dockerhub.sh

stop-and-remove:
	docker stop don_central_hub && \
	docker rm don_central_hub

run-latest:
	./check_behind.sh