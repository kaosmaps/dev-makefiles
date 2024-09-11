# tests/test_core.py
import pytest
from dev_makefiles.core.demo import demo_function
from dev_makefiles.core.config import settings

def test_demo_function():
    assert demo_function() == 'Hello from dev-makefiles core!'

def test_settings():
    assert settings.PROJECT_NAME == "dev-makefiles"
    assert settings.API_V1_STR == "/api/v1"

@pytest.fixture
def demo_fixture():
    return "test fixture"

def test_with_fixture(demo_fixture):
    assert demo_fixture == "test fixture"
