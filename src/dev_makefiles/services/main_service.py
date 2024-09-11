# src/dev_makefiles/services/main_service.py
from dev_makefiles.core import demo_function

class MainService:
    def main_function(self):
        return f'Service says: {demo_function()}'
