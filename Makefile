.PHONY: all


### DOCKER ###
start_db:
	docker-compose -f docker-compose.db.yml up

stop_db:
	docker-compose -f docker-compose.db.yml down --remove-orphans


### DEV ###
start_server:
	cd chat_be && mix phx.server

start_ui:
	cd chat_fe && npm run dev

