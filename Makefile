PROJECT_NAME = #Project name here
MAKE := make

.PHONY: all clean run serve update update_pip update_bower makemigrations \ 
	migrate setup

all: update makemigrations migrate run

run:
	python manage.py runserver

serve:
	python manage.py runserver 0.0.0.0:8000

update: update_pip update_bower

update_pip:
	@echo 'Installing Python requirements'
	@echo '------------------------------'
# Installing Django like this until 1.7 is released
	pip install https://www.djangoproject.com/download/1.7.b4/tarball/
# Rest of requirements
	pip install -r requirements.txt

update_bower:
	@echo 'Install static dependencies'
	@echo '---------------------------'
	bower install

makemigrations:
	@echo 'Making migrations for all apps'
	@echo '------------------------------'
	python manage.py makemigrations

migrate:
	@echo 'Running migrations'
	@echo '------------------'
	python manage.py migrate

setup: update
	@echo 'Copying settings example'
	@echo '------------------------'
	cp $(PROJECT_NAME)/settings/local.py.example \
		$(PROJECT_NAME)/settings/local.py
	$(MAKE) migrate
	@echo '$(PROJECT_NAME) is ready. make run to start development server.'

