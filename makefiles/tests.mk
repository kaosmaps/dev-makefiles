# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
include makefiles/config.mk

.PHONY: .create-tests .run-tests

.create-tests:
	@echo "Creating test structure and files..."
	@mkdir -p $(TARGET_DIR)/tests
	@echo "$$TEST_INIT_CONTENT" > $(TARGET_DIR)/tests/__init__.py
	@echo "$$TEST_CORE_CONTENT" > $(TARGET_DIR)/tests/test_core.py
	@echo "$$TEST_SERVICES_CONTENT" > $(TARGET_DIR)/tests/test_services.py

.run-tests:
	@echo "Running tests..."
	poetry run pytest tests

define TEST_INIT_CONTENT
# tests/__init__.py
# This file is intentionally left empty to mark the directory as a Python package.
endef
export TEST_INIT_CONTENT

define TEST_CORE_CONTENT
# tests/test_core.py
import pytest
from $(subst -,_,$(SAUBER_PACKAGE_NAME)).core.demo import demo_function
from $(subst -,_,$(SAUBER_PACKAGE_NAME)).core.config import settings

def test_demo_function():
    assert demo_function() == 'Hello from $(SAUBER_PACKAGE_NAME) core!'

def test_settings():
    assert settings.PROJECT_NAME == "$(SAUBER_PACKAGE_NAME)"
    assert settings.API_V1_STR == "/api/v1"

@pytest.fixture
def demo_fixture():
    return "test fixture"

def test_with_fixture(demo_fixture):
    assert demo_fixture == "test fixture"
endef
export TEST_CORE_CONTENT

define TEST_SERVICES_CONTENT
# tests/test_services.py
import pytest
from $(subst -,_,$(SAUBER_PACKAGE_NAME)).services import MainService
from $(subst -,_,$(SAUBER_PACKAGE_NAME)).core import demo_function

def test_main_service():
    service = MainService()
    assert service.main_function() == f'Service says: {demo_function()}'

@pytest.fixture
def main_service():
    return MainService()

def test_main_service_with_fixture(main_service):
    assert main_service.main_function() == f'Service says: {demo_function()}'

def test_main_service_integration():
    service = MainService()
    result = service.main_function()
    assert 'Service says:' in result
    assert 'Hello from $(SAUBER_PACKAGE_NAME) core!' in result
endef
export TEST_SERVICES_CONTENT
