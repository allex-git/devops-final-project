from fastapi import FastAPI
import socket

app = FastAPI()

def get_host_info():
    hostname = socket.gethostname()
    try:
        ip = socket.gethostbyname(hostname)
    except Exception:
        ip = "unknown"
    return hostname, ip


@app.get("/")
def root():
    hostname, ip = get_host_info()
    return {
        "status": "ok",
        "hostname": hostname,
        "ip": ip,
        "author": "Allex_DevOps"
    }


@app.get("/healthz")
def health():
    return {
        "status": "healthy"
    }