import socket
import secrets
import uvicorn
import os

from fastapi import FastAPI


app = FastAPI()


@app.get('/randomizer')
def randomizer(length: int = 32):
    return secrets.token_urlsafe(length)


@app.get('/environment')
def current_environment():
    return {
        'hostname': socket.gethostname(),
        'pid': os.getpid(),
    }


if __name__ == '__main__':
    uvicorn.run('app:app', port=5000, reload=True)

