# Devops Final Project
DevOps Final Project: Python (FastAPI) + Docker + Kubernetes + AWS EKS + ArgoCD


# Крок 01 (Python App)

## опис
це простий backend-сервіс на Python, створений з використанням FastAPI.

Сервіс надає:
- базовий endpoint для перевірки доступності
- інформацію про контейнер (hostname та IP)
- основу для подальшої контейнеризації та деплою

---

## структура проєкту
```
.
.
├── .github/
│   └── workflows/
│    └── docker.yml
├── Dockerfile
└── app/
    ├── main.py
    └── requirements.txt

```

---

## технології
- Python 3.x
- FastAPI
- Uvicorn (ASGI server)

---

## запуск локально

### 1. Встановлення залежностей
```bash
pip install -r requirements.txt
```

### 2. запуск сервісу
```bash
uvicorn main:app --host 0.0.0.0 --port 8800
```

---

## доступні endpoint

### `GET /`
повертає інформацію про сервіс:

```json
{
  "status": "ok",
  "hostname": "container-hostname",
  "ip": "container-ip",
  "author": "Allex_DevOps"
}
```

---

### `GET /healthz`
endpoint для перевірки стану сервісу:

```json
{
  "status": "healthy"
}
```

---

## деталі реалізації

- Використовується модуль `socket` для отримання:
  - hostname
  - IP адреси
- Сервіс:
  - є stateless
  - готовий до роботи в контейнерах

---

## перевірка роботи

```bash
curl http://localhost:8800/
curl http://localhost:8800/healthz
```

---

## примітки
- Порт `8800` використовується для локального запуску
- Сервіс слухає `0.0.0.0` 

---


# Крок 02 (Docker)

## опис
На цьому етапі додаток був контейнеризований з використанням Docker.

Контейнер:
- використовує мінімальний офіційний образ Python
- встановлює залежності
- запускає FastAPI backend

---

## Dockerfile

```dockerfile
FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY app/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app/ .

RUN useradd -m appuser
USER appuser

EXPOSE 8800

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8800"]
```

---


## збірка контейнера

```bash
docker build -t fastapi-app .
```

---

## запуск контейнера

```bash
docker run -p 8800:8800 fastapi-app
```

---

## перевірка роботи

```bash
curl http://localhost:8800/
curl http://localhost:8800/healthz
```

---

## результат

Сервіс доступний за адресою:

http://localhost:8800

---

## офіційна документація

- https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
- https://hub.docker.com/_/python
- https://fastapi.tiangolo.com/deployment/docker/

---

## примітки

- порт 8800 використовується для контейнера
- сервіс слухає 0.0.0.0

# Крок 03 (CI/CD - GitHub Actions)

## опис
На цьому етапі було налаштовано CI/CD pipeline з використанням GitHub Actions.

Pipeline автоматично:
- збирає Docker image
- авторизується в Docker Hub
- пушить image в репозиторій

---

## workflow (docker.yml)

```yaml
name: Build and Push Docker Image

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Login to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: Build and Push
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: alexdevops05/finalproject:latest
          
```

---

## GitHub Secrets

Для роботи pipeline використані secrets:

- DOCKERHUB_USERNAME
- DOCKERHUB_TOKEN

---

## як це працює

git push → GitHub Actions → build Docker image → push в Docker Hub

---

## перевірка роботи

### 1. GitHub Actions
Перевірити вкладку Actions — статус pipeline має бути Success

### 2. Docker Hub
Перевірити наявність image:
alexdevops05/finalproject:latest

### 3. локальний запуск

```bash
docker pull alexdevops05/finalproject:latest
docker run -p 8800:8800 alexdevops05/finalproject:latest
```

---

## результат

Docker image автоматично збирається та публікується при кожному push у гілку main.

---

## офіційна документація

- https://docs.github.com/actions
- https://docs.docker.com/build/ci/github-actions/