# tests/test_services.py
import pytest
from dev_makefiles.services import MainService
from dev_makefiles.core import demo_function

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
    assert 'Hello from dev-makefiles core!' in result
