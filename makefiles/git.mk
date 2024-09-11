# Version: 1.0.1
# Last updated: 2024-03-14

include makefiles/git_repo.mk
include makefiles/git_pre_commit.mk

.PHONY: .setup-git

.setup-git:
	@echo "Setting up Git..."
	@$(MAKE) -f makefiles/git_repo.mk .git-repo-setup
	@$(MAKE) -f makefiles/git_repo.mk .git-gitignore-create
	@$(MAKE) -f makefiles/git_pre_commit.mk .git-pre-commit-setup
	@echo "Git setup complete."
