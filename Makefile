# Licensed under the MIT license:
# http://www.opensource.org/licenses/MIT-license
# Copyright (c) 2021, kaija <kaija.chang@gmail.com>

all: build
# lists all available targets
list:
	@sh -c "$(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | grep -v 'make\[1\]' | grep -v 'Makefile' | sort"
# required for list
no_targets__:

# test your application (tests in the tests/ directory)
test: unit

unit:
	@coverage run --branch `which nosetests` -vv --with-yanc -s tests/
	@coverage report -m --fail-under=80

# show coverage in html format
coverage-html: unit
	@coverage html

migration:
	@cd app/ && alembic revision -m "$(DESC)"

auto_migration:
	@cd app/ && alembic revision --autogenerate -m "$(DESC)"

drop:
	@-cd app/ && alembic downgrade base
	@$(MAKE) drop_now

drop_now:
	@mysql -u root -e "DROP DATABASE IF EXISTS app; CREATE DATABASE IF NOT EXISTS app"
	@echo "DB RECREATED"

drop_test:
	@mysql -u root -e "DROP DATABASE IF EXISTS test_app; CREATE DATABASE IF NOT EXISTS test_app"
	@echo "DB RECREATED"

data:
	@cd app/ && alembic upgrade head

data_test:
	@cd tests/ && alembic upgrade head

db: drop data

db_test: drop_test data_test



# run tests against all supported python versions
tox:
	@tox

build:
	docker build -t fastapi-best .

run:
	docker run -d -p 8080:80 --name fast fastapi-best

stop:
	docker stop fast
	docker rm fast

