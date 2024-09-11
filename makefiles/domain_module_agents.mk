# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
include makefiles/config.mk

SAUBER_DOMAIN := agents

.PHONY: .create-domain-module-agents

.create-domain-module-agents:
	@echo "Creating domain module structures and files for agents..."
	@$(MAKE) -f makefiles/module_core.mk .create-module-core SAUBER_DOMAIN=agents
	
# @$(MAKE) -f makefiles/module_api.mk .create-module-api SAUBER_DOMAIN=$(SAUBER_DOMAIN)
# @$(MAKE) -f makefiles/module_services.mk .create-module-services SAUBER_DOMAIN=$(SAUBER_DOMAIN)
# @$(MAKE) -f makefiles/module_cli.mk .create-module-cli SAUBER_DOMAIN=$(SAUBER_DOMAIN)
# @$(MAKE) -f makefiles/module_app.mk .create-module-app SAUBER_DOMAIN=$(SAUBER_DOMAIN)
# @$(MAKE) -f makefiles/module_resources.mk .create-module-resources SAUBER_DOMAIN=$(SAUBER_DOMAIN)
# @$(MAKE) -f makefiles/module_utils.mk .create-module-utils SAUBER_DOMAIN=$(SAUBER_DOMAIN)