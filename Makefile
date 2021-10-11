PROJECT=myrailsapp

c:
	@bundle exec rails console

migrate:
	@bundle exec rails db:migrate

up:
	@bundle exec rails server -p 3000 

docker.build:
	@docker-compose -p "$(APP_NAME)" build .

docker.start:
	@docker-compose -p "$(APP_NAME)" up 

docker.stop: 
	@docker-compose -p "$(APP_NAME)" down

docker.clean:
	@docker-compose -p "$(APP_NAME)" down -v --rmi local --remove-orphans
