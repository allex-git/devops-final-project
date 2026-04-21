# Devops Final Project
DevOps Final Project: Python (FastAPI) + Docker + Kubernetes + AWS EKS + ArgoCD

# DevOps Final Project — Крок 01 (Python App)

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

## доступні endpoint-и

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