build:
	docker-compose build

run:
	docker-compose up -d

stop:
	docker-compose down

clean:
	docker-compose down --volumes --remove-orphans

rebuild:
	docker-compose down
	docker-compose build --no-cache
	docker-compose up -d
