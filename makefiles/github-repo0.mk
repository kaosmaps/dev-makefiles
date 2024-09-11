# Version: 1.0.0
# Last updated: 2023-12-13

# GitHub-related tasks
.PHONY: .github-repo-setup .github-repo-push

.github-repo-setup:
	@echo "Setting up GitHub repository..."
	@if [ "$(call confirm,Create GitHub repository?,N)" = "true" ]; then \
		if command -v gh >/dev/null 2>&1; then \
			if [ -z "$$(gh auth status 2>&1 | grep Logged)" ]; then \
				echo "Please log in to GitHub:"; \
				gh auth login; \
			fi; \
			REPO_NAME=$(call user_input,Enter repository name,$(SAUBER_PACKAGE_NAME)); \
			if [ "$(call confirm,Make repository private?,$(GITHUB_REPO_PRIVATE))" = "true" ]; then \
				VISIBILITY="--private"; \
			else \
				VISIBILITY="--public"; \
			fi; \
			if gh repo view $(GITHUB_ORG)/$$REPO_NAME >/dev/null 2>&1; then \
				echo "Repository $(GITHUB_ORG)/$$REPO_NAME already exists on GitHub."; \
			else \
				gh repo create $(GITHUB_ORG)/$$REPO_NAME $$VISIBILITY; \
			fi; \
		else \
			echo "GitHub CLI (gh) not found. Please install it to use this feature."; \
			echo "Alternatively, create the repository manually on GitHub."; \
			exit 1; \
		fi; \
	else \
		echo "Skipping GitHub repository creation."; \
	fi
	@if [ -z "$$(git remote | grep origin)" ]; then \
		if [ "$(call confirm,Add GitHub remote 'origin'?,N)" = "true" ]; then \
			REPO_NAME=$(call user_input,Enter repository name,$(SAUBER_PACKAGE_NAME)); \
			git remote add origin https://github.com/$(GITHUB_ORG)/$$REPO_NAME.git; \
			echo "Added GitHub remote 'origin'."; \
		else \
			echo "Skipping adding GitHub remote."; \
		fi; \
	else \
		echo "Remote 'origin' already exists. Skipping."; \
	fi

# .github-repo-push:
# 	@echo "Pushing to GitHub..."
# 	@if [ -z "$$(git status --porcelain)" ]; then \
# 		echo "No changes to commit."; \
# 	else \
# 		git add .; \
# 		COMMIT_MSG="Initial commit"; \
# 		if [ -z "$$COMMIT_MSG" ]; then \
# 			echo "Commit message cannot be empty."; \
# 			exit 1; \
# 		fi; \
# 		git commit -m "$$COMMIT_MSG" --no-verify; \
# 	fi
# 	@if [ -z "$$(git branch --show-current)" ]; then \
# 		git checkout -b main; \
# 	fi
# 	git push -u origin $$(git branch --show-current)
# 	@echo "Push to GitHub complete."

.github-repo-push:
	@echo "Pushing to GitHub..."
	@if [ -z "$$(git status --porcelain)" ]; then \
		echo "No changes to commit."; \
	else \
		git add .; \
		if [ "$(SAUBER_AUTO_CONFIRM)" = "false" ]; then \
			read -p "Enter commit message: " COMMIT_MSG; \
		else \
			COMMIT_MSG="Update"; \
		fi; \
		if [ -z "$$COMMIT_MSG" ]; then \
			echo "Commit message cannot be empty."; \
			exit 1; \
		fi; \
		git commit -m "$$COMMIT_MSG" --no-verify; \
	fi
	@if [ -z "$$(git branch --show-current)" ]; then \
		git checkout -b main; \
	fi
	git push -u origin $$(git branch --show-current)
	@echo "Push to GitHub complete."

# COMMIT_MSG=$(call user_input,Enter commit message,Update); \