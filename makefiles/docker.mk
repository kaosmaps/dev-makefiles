# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
include makefiles/config.mk

# Docker-related tasks
.PHONY: .create-dockerfiles

define BASE_DOCKERFILE_CONTENT
FROM python:$(SAUBER_PYTHON_VERSION)-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Add Poetry to PATH
ENV PATH="$${PATH}:/root/.local/bin"

# Configure Poetry
RUN poetry config virtualenvs.create false

# Set working directory
WORKDIR /app

# Copy only requirements to cache them in docker layer
COPY pyproject.toml poetry.lock* ./

# Project initialization:
RUN poetry install --no-interaction --no-ansi --no-root

# Copy project
COPY . .

# Install project
RUN poetry install --no-interaction --no-ansi

# Copy model files (if applicable)
# COPY $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/core/models /app/$(subst -,_,$(SAUBER_PACKAGE_NAME))/core/models

# Run download script (if applicable)
# RUN python -c "from $(subst -,_,$(SAUBER_PACKAGE_NAME)).core import download_model_files; download_model_files()"
endef
export BASE_DOCKERFILE_CONTENT

define SERVICE_DOCKERFILE_CONTENT
FROM $(subst -,_,$(SAUBER_PACKAGE_NAME))_base

WORKDIR /app/services

CMD ["poetry", "run", "python", "-m", "$(subst -,_,$(SAUBER_PACKAGE_NAME)).services"]
endef
export SERVICE_DOCKERFILE_CONTENT

define CLI_DOCKERFILE_CONTENT
FROM $(subst -,_,$(SAUBER_PACKAGE_NAME))_base

WORKDIR /app/cli

ENTRYPOINT ["poetry", "run", "$(subst -,_,$(SAUBER_PACKAGE_NAME))"]
endef
export CLI_DOCKERFILE_CONTENT

define API_DOCKERFILE_CONTENT
FROM $(subst -,_,$(SAUBER_PACKAGE_NAME))_base

WORKDIR /app/api

CMD ["poetry", "run", "uvicorn", "$(subst -,_,$(SAUBER_PACKAGE_NAME)).api:app", "--host", "0.0.0.0", "--port", "8000"]
endef
export API_DOCKERFILE_CONTENT

define APP_DOCKERFILE_CONTENT
FROM $(subst -,_,$(SAUBER_PACKAGE_NAME))_base

WORKDIR /app

CMD ["poetry", "run", "streamlit", "run", "src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/app/main.py", "--server.port=8501", "--server.address=0.0.0.0"]
endef
export APP_DOCKERFILE_CONTENT

define DOCKER_COMPOSE_CONTENT
version: '3.8'

services:
  api:
    build:
      context: .
      dockerfile: $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/Dockerfile
    working_dir: /app
    ports:
      - "8000:8000"
  app:
    build:
      context: .
      dockerfile: $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/app/Dockerfile
    working_dir: /app
    ports:
      - "8501:8501"
  cli:
    build:
      context: .
      dockerfile: $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/cli/Dockerfile
    working_dir: /app
  services:
    build:
      context: .
      dockerfile: $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/services/Dockerfile
    working_dir: /app
endef
export DOCKER_COMPOSE_CONTENT

.create-dockerfiles:
	@echo "Creating Dockerfiles..."
	@mkdir -p $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))
	@mkdir -p $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/services
	@mkdir -p $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/cli
	@mkdir -p $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api
	@mkdir -p $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/app
	@echo "$$BASE_DOCKERFILE_CONTENT" > $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/Dockerfile.base
	@echo "$$SERVICE_DOCKERFILE_CONTENT" > $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/services/Dockerfile
	@echo "$$CLI_DOCKERFILE_CONTENT" > $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/cli/Dockerfile
	@echo "$$API_DOCKERFILE_CONTENT" > $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/Dockerfile
	@echo "$$APP_DOCKERFILE_CONTENT" > $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/app/Dockerfile
	@echo "$$DOCKER_COMPOSE_CONTENT" > $(TARGET_DIR)/docker-compose.yml
	@echo "Dockerfiles and docker-compose.yml created."
