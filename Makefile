park-startup: install-dependencies prepare-db start-server

sidekiq-startup: install-dependencies start-worker

install-dependencies:
	bundle install

prepare-db:
	bundle exec rails db:prepare

start-server:
	rm -f tmp/pids/server.pid && bundle exec rails server -b 0.0.0.0

start-worker:
	bundle exec sidekiq

exec:
	docker compose exec -it park_app /bin/sh

fix-permissions:
	sudo chown -R $(USER):$(USER) ./*