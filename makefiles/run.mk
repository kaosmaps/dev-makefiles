# Framework version: 0.0.1
# Module version: 0.0.1

# Tasks for running different parts of the application
.PHONY: .run-streamlit .run-api .run-cli

.run-streamlit:
	poetry run python -m $(subst -,_,$(SAUBER_PACKAGE_NAME)).main app

.run-api:
	poetry run python -m $(subst -,_,$(SAUBER_PACKAGE_NAME)).main api

.run-cli:
	poetry run python -m $(subst -,_,$(SAUBER_PACKAGE_NAME)).main cli
