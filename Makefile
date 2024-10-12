#/*
# * This file is part of kgiflwl/v2board-compose.
# *
# * kgiflwl/v2board-compose is free software: you can redistribute it and/or modify
# * it under the terms of the GNU General Public License as published by
# * the Free Software Foundation, either version 3 of the License, or
# * (at your option) any later version.
# *
# * kgiflwl/v2board-compose is distributed in the hope that it will be useful,
# * but WITHOUT ANY WARRANTY; without even the implied warranty of
# * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# * GNU General Public License for more details.
# *
# * You should have received a copy of the GNU General Public License
# * along with kgiflwl/v2board-compose. If not, see <https://www.gnu.org/licenses/>.
# */

IMAGE_TAG  ?= kgiflwl/lcrp:latest
DOCKER_DIR ?= docker

DB_ROOT_PASSWORD ?= your_db_root_password
DB_DATABASE      ?= your_db
DB_USERNAME      ?= your_db_username
DB_PASSWORD      ?= your_db_password

V2BOARD_VERSION ?= master

COMPOSE_CMD := $(shell if which docker-compose >/dev/null 2>&1; then echo docker-compose; else echo docker compose; fi)

.PHONY: kgiflwl-lcrp-docker-image
kgiflwl-lcrp-docker-image:
	docker build -t $(IMAGE_TAG) -f $(DOCKER_DIR)/Dockerfile .

.PHONY: upload
upload:
	echo $(DOCKER_PASSWORD) | docker login -u $(DOCKER_USERNAME) --password-stdin
	docker push $(IMAGE_TAG)

.PHONY: database
database:
	sh -c "DB_DATABASE=$(DB_DATABASE) DB_USERNAME=$(DB_USERNAME) DB_PASSWORD=$(DB_PASSWORD) ./config/docker-entrypoint-initdb.d/init.sh"

.PHONY: data-backup
data-backup:
	@$(COMPOSE_CMD) down
	@TIMESTAMP=$(shell date +%Y%m%d%H%M%S); \
	[ -d data ] && mv data data.$$TIMESTAMP || true ; \
	[ -d v2board ] && mv v2board v2board.$$TIMESTAMP && mkdir data || true

.PHONY: v2board-install
v2board-install: data-backup database
	git clone -b $(V2BOARD_VERSION) --depth 1 https://github.com/v2board/v2board.git
	$(COMPOSE_CMD) up -d
	@docker exec -ti www sh init.sh
	@$(COMPOSE_CMD) restart www
