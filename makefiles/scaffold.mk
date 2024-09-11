# Framework version: 0.0.1
# Module version: 0.0.1

# Central  coordinator
.PHONY: .ensure-package .ensure-package-files

.ensure-package:
	@echo "Creating leftover stuff..."
	@$(MAKE) -f makefiles/scaffold_github_workflows.mk .scaffold-github-workflows

.ensure-package-files:
	@echo "Creating project files..."
	@$(MAKE) -f makefiles/scaffold_github_workflows.mk .create-github-workflow-files
