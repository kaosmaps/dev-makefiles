# Framework version: 0.0.1
# Module version: 0.0.1

include makefiles/github-repo.mk
include makefiles/github_workflows.mk

.PHONY: .setup-github

.setup-github:
	@echo "Setting up GitHub..."
	@$(MAKE) -f makefiles/github-repo.mk .github-repo-setup
	@$(MAKE) -f makefiles/github_workflows.mk .github-workflows-setup
	@$(MAKE) -f makefiles/github-repo.mk .github-repo-push
