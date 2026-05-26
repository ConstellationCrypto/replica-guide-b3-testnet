b3-up:
	@bash ./b3-up.sh
.PHONY: b3-up

b3-down:
	@(docker-compose -f docker-compose.yml down)
.PHONY: b3-down

b3-clean: b3-down
	docker image ls 'b3-replica*' --format='{{.Repository}}' | xargs -r docker rmi
	docker volume ls --filter name=b3-replica --format='{{.Name}}' | xargs -r docker volume rm
.PHONY: b3-clean

b3-reth-up:
	@bash ./b3-reth-up.sh
.PHONY: b3-reth-up

b3-reth-down:
	@(docker compose -f docker-compose-reth.yml down)
.PHONY: b3-reth-down
