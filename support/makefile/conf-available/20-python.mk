PYTHON_VERSION ?= 3.8

.PHONY: install
## @python lance un pip install -r requirements.txt
install: .venv/bin/pip
	docker run \
        --rm \
        --name python \
        -ti \
        --user 1000 \
        -v $(CURDIR):/srv/www \
        -w /srv/www \
        python:$(PYTHON_VERSION) \
        ./.venv/bin/pip install -r requirements.txt

.venv/bin/pip: .venv/bin/python
	docker run \
        --rm \
        --name python \
        -ti \
        --user 1000 \
        -v $(CURDIR):/srv/www \
        -w /srv/www \
        python:$(PYTHON_VERSION) \
        ./.venv/bin/pip  $(args)

.venv/bin/python:
	docker run --rm --name python \
        -ti \
        --user 1000 \
        -v $(CURDIR):/srv/www \
        -w /srv/www \
        python:$(PYTHON_VERSION) \
        python3 -m venv .venv

