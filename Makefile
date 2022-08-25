NAME=inception

DOCKER_COMPOSE_YML=srcs/docker-compose.yml
DOCKER_COMPOSE_FLAGS=-p $(NAME) -f $(DOCKER_COMPOSE_YML)
VOLUMES_ROOT=./srcs/data

.PHONY: build
build:
	docker-compose $(DOCKER_COMPOSE_FLAGS) build

.PHONY: up
up:
	docker-compose $(DOCKER_COMPOSE_FLAGS) up -d

.PHONY: down
down:
	docker-compose $(DOCKER_COMPOSE_FLAGS) down

.PHONY: clean
clean: down
	rm -rf $(VOLUMES_ROOT)
	docker system prune --force
	docker system prune --volumes --force
	docker rmi `docker images -q` --force

.PHONY: reload
reload: clean build up

.PHONY: logs
logs:
	docker-compose $(DOCKER_COMPOSE_FLAGS) logs --follow

.PHONY: top
top:
	docker-compose $(DOCKER_COMPOSE_FLAGS) top

.PHONY: ps
ps:
	docker-compose $(DOCKER_COMPOSE_FLAGS) ps