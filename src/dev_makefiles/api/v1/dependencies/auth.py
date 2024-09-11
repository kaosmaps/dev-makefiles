# src/dev_makefiles/api/v1/dependencies/auth.py
from fastapi import Depends
from fastapi.security import OAuth2PasswordBearer
from dev_makefiles.api.v1.models.user import User

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

async def get_current_user(token: str = Depends(oauth2_scheme)):
    # This is a placeholder implementation. In a real app, you'd verify the token
    # and fetch the user from a database.
    user = User(id=1, email="user@example.com", is_active=True)
    return user
