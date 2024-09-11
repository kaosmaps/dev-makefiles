# Version: 1.0.11
# Last updated: 2024-03-14

# Central  coordinator
.PHONY: .ensure-package .ensure-package-files

.ensure-package:
	@echo "Creating leftover stuff..."
	@$(MAKE) -f makefiles/scaffold_github_workflows.mk .scaffold-github-workflows

.ensure-package-files:
	@echo "Creating project files..."
	@$(MAKE) -f makefiles/scaffold_github_workflows.mk .create-github-workflow-files
