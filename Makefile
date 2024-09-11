# Makefile Framework Version: 1.1.0
# Last updated: 2024-03-14

# Main Makefile
include makefiles/config.mk
include makefiles/confirm.mk
include makefiles/*.mk

$(info TARGET_DIR=$(TARGET_DIR))
$(info SRC_DIR=$(SRC_DIR))
$(info SAUBER_PACKAGE_NAME=$(SAUBER_PACKAGE_NAME))

ifeq ($(SAUBER_PACKAGE_TYPE),standard)
    SAUBER_PACKAGE_NAME_PYTHON := $(subst -,_,$(SAUBER_PACKAGE_NAME))
else ifeq ($(SAUBER_PACKAGE_TYPE),subpackage)
    SAUBER_PACKAGE_NAME_PYTHON := $(SAUBER_PACKAGE_PARENT).$(subst -,_,$(notdir $(SAUBER_PACKAGE_NAME)))
else
    $(error Invalid SAUBER_PACKAGE_TYPE. Must be 'standard' or 'subpackage')
endif

.PHONY: activate-venv all clean create-dockerfiles create-files create-modules create-package create-pyproject create-readme-notebook create-scripts generate-readme install-deps scaffold setup-env setup-git setup-github setup-hooks test update-readme-notebook docker-setup docker-build docker-compose-up create-utils create-docs

# Main target that sets up the entire project
all: clean create-package create-pyproject create-modules create-domain-modules create-tests create-scripts create-dockerfiles generate-readme create-readme-notebook setup-env activate-venv install-deps setup-git setup-hooks setup-github

activate-venv:
	@$(MAKE) -f makefiles/environment.mk .activate-venv

clean:
	@$(MAKE) -f makefiles/clean.mk .clean

create-dockerfiles:
	@$(MAKE) -f makefiles/docker.mk .create-dockerfiles

create-modules:
	@$(MAKE) -f makefiles/modules.mk .create-modules

create-domain-modules:
	@$(MAKE) -f makefiles/domain_module_agents.mk .create-domain-module-agents

create-package:
	@$(MAKE) -f makefiles/package.mk .create-package TARGET_DIR=$(TARGET_DIR)

create-pyproject:
	@$(MAKE) -f makefiles/pyproject.mk .create-pyproject TARGET_DIR=$(TARGET_DIR)

create-readme-notebook:
	@$(MAKE) -f makefiles/notebooks.mk .create-readme-notebook

create-scripts:
	@$(MAKE) -f makefiles/scripts.mk .create-scripts

create-tests:
	@$(MAKE) -f makefiles/tests.mk .create-tests

generate-readme:
	@$(MAKE) -f makefiles/readme.mk .generate-readme

install-deps:
	@$(MAKE) -f makefiles/environment.mk .install-deps

setup-env:
	@$(MAKE) -f makefiles/environment.mk .setup-env

setup-git:
	@$(MAKE) -f makefiles/git.mk .setup-git

setup-github:
	@$(MAKE) -f makefiles/github.mk .setup-github

setup-hooks:
	@$(MAKE) -f makefiles/environment.mk .setup-hooks

test:
	@$(MAKE) -f makefiles/scaffold_tests.mk .run-tests

update-readme-notebook:
	@$(MAKE) -f makefiles/notebook.mk .update-readme-notebook

create-utils:
	@$(MAKE) -f makefiles/utils.mk .create-utils

create-docs:
	@$(MAKE) -f makefiles/docs.mk .create-docs

#-----

docker-setup: docker-build docker-compose-up
