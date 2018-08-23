up:
	docker-compose up -d --build

down:
	docker-compose down

sh:
	docker-compose run --rm app sh -i

cqlsh:
	docker-compose run --rm cqlsh sh -c 'exec cqlsh local.db 9042'

init:
	docker-compose run --rm cqlsh sh -c 'exec cqlsh -f ~/src/init.cql local.db 9042'

app-run:
	docker-compose run --rm app sh -c 'eval $$(luarocks path) && exec lua ~/src/index.lua'
