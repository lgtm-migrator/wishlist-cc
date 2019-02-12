# vim: set tabstop=8 softtabstop=8 noexpandtab:

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  all            to setup everything at once (including install, migrations)"
	@echo "  run            to run everything"
	@echo "  reset-env      to reset environment to default values"
	@echo "  restart        to restart everything"
	@echo "  stop           to stop everything"
	@echo "  logs           to tail logs of everything"
	@echo "  install        to install everything"
	@echo "  enter          to stop everything"
	@echo "  destroy        to destroy everything (clears docker volumes and images also)"
	@echo "  test-unit      to run unit tests"

all: run install

build:
	@docker-compose build

run:
	@if [ ! -e "server/.env" ]; then\
		cp .env.example .env; \
	fi
	@docker-compose up -d
	@echo "Services are up and running:"
	@echo "  Client: http://localhost:3000"
	@echo "  Server: http://localhost:4040"


stop:
	@docker-compose stop

restart:
	@docker-compose restart

logs:
	@docker-compose logs -f

enter-client:
	@docker-compose run --rm --user root --entrypoint /bin/sh client_adidas

enter-servert:
	@docker-compose run --rm --user root --entrypoint /bin/sh api_adidas

destroy:
	@docker-compose down --rmi local