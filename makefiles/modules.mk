# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
# include makefiles/config.mk

# Module coordinator
.PHONY: .create-modules .create-domain-modules

.create-modules:
	@echo "Creating module structures and files..."
	@$(MAKE) -f makefiles/module_core.mk .create-module-core
	@$(MAKE) -f makefiles/module_api.mk .create-module-api
	@$(MAKE) -f makefiles/module_services.mk .create-module-services
	@$(MAKE) -f makefiles/module_cli.mk .create-module-cli
	@$(MAKE) -f makefiles/module_app.mk .create-module-app
	@$(MAKE) -f makefiles/module_resources.mk .create-module-resources
	@$(MAKE) -f makefiles/module_utils.mk .create-module-utils

.create-domain-modules:
	@echo "Creating domain module structures and files..."
	@$(MAKE) -f makefiles/domain_module_core.mk .create-domain-module-core
	@$(MAKE) -f makefiles/domain_module_api.mk .create-domain-module-api
	@$(MAKE) -f makefiles/domain_module_services.mk .create-domain-module-services
	@$(MAKE) -f makefiles/domain_module_cli.mk .create-domain-module-cli
	@$(MAKE) -f makefiles/domain_module_app.mk .create-domain-module-app
	@$(MAKE) -f makefiles/domain_module_resources.mk .create-domain-module-resources
	@$(MAKE) -f makefiles/domain_module_utils.mk .create-domain-module-utils
