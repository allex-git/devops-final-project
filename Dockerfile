# 1. Минимальный официальный образ
FROM python:3.12-slim

# 2. ENV (best practice)
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 3. Рабочая директория
WORKDIR /app

# 4. Установка зависимостей (минимально)
RUN apt-get update && apt-get install -y --no-install-recommends && rm -rf /var/lib/apt/lists/*

# 5. Копируем зависимости (для кеша)
COPY app/requirements.txt .

# 6. Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# 7. Копируем код
COPY app/ .

# 8. Non-root пользователь (security best practice)
RUN useradd -m appuser
USER appuser

# 9. Порт
EXPOSE 8800

# 10. Запуск
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8800"]