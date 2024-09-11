# src/dev_makefiles/config.py
from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
    API_V1_STR: str = "/api/v1"
    PROJECT_NAME: str = "dev-makefiles"
    API_HOST: str = "0.0.0.0"
    API_PORT: int = 8000
    APP_HOST: str = "0.0.0.0"
    APP_PORT: int = 8501

    model_config = SettingsConfigDict(env_file=".env", extra="ignore")

settings = Settings()
