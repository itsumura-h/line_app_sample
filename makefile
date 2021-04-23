dev:
	docker-compose build
	docker-compose up -d

static:
	docker-compose -f docker-compose.static.yaml build
	docker-compose -f docker-compose.static.yaml up -d

static-stop:
	docker-compose -f docker-compose.static.yaml stop

static-logs:
	docker-compose -f docker-compose.static.yaml logs
