# Framework version: 1.0.0
# Module version: 1.0.0

include makefiles/confirm.mk

# GitHub-related tasks
.PHONY: .github-repo-setup .github-repo-push

.github-repo-setup:
	@echo "Setting up GitHub repository..."
	@if [ "$(call confirm,Create GitHub repository?,Y)" = "true" ]; then \
		if command -v gh >/dev/null 2>&1; then \
			if [ -z "$$(gh auth status 2>&1 | grep Logged)" ]; then \
				echo "Please log in to GitHub:"; \
				gh auth login; \
			fi; \
			REPO_NAME=$(call user_input,Enter repository name,$(SAUBER_PACKAGE_NAME)); \
			if gh repo view $(GITHUB_ORG)/$$REPO_NAME >/dev/null 2>&1; then \
				echo "Repository $(GITHUB_ORG)/$$REPO_NAME already exists on GitHub."; \
			else \
				if [ "$(call confirm,Make repository private?,$(GITHUB_REPO_PRIVATE))" = "true" ]; then \
					VISIBILITY="--private"; \
				else \
					VISIBILITY="--public"; \
				fi; \
				gh repo create $(GITHUB_ORG)/$$REPO_NAME $$VISIBILITY; \
			fi; \
			if [ -z "$$(git remote | grep origin)" ]; then \
				git remote add origin https://github.com/$(GITHUB_ORG)/$$REPO_NAME.git; \
				echo "Added GitHub remote 'origin'."; \
			else \
				echo "Remote 'origin' already exists. Skipping."; \
			fi; \
		else \
			echo "GitHub CLI (gh) not found. Please install it to use this feature."; \
			echo "Alternatively, create the repository manually on GitHub."; \
			exit 1; \
		fi; \
	else \
		echo "Skipping GitHub repository creation."; \
	fi

.github-repo-push:
	@echo "Pushing to GitHub..."
	@if [ -z "$$(git status --porcelain)" ]; then \
		echo "No changes to commit."; \
	else \
		git add .; \
		if [ "$(SAUBER_AUTO_CONFIRM)" = "false" ]; then \
			COMMIT_MSG=$(call user_input,Enter commit message,Update); \
		else \
			COMMIT_MSG="Update"; \
		fi; \
		if [ -z "$$COMMIT_MSG" ]; then \
			echo "Commit message cannot be empty."; \
			exit 1; \
		fi; \
		git commit -m "$$COMMIT_MSG" --no-verify; \
	fi
	@if [ -z "$$(git remote | grep origin)" ]; then \
		echo "Remote 'origin' not found. Please set up the remote before pushing."; \
		exit 1; \
	fi
	@if [ -z "$$(git branch --show-current)" ]; then \
		git checkout -b main; \
	fi
	git push -u origin $$(git branch --show-current)
	@echo "Push to GitHub complete."