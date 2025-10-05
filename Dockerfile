# syntax=docker/dockerfile:1.7
FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1

WORKDIR /app

# Alleen requirements kopiëren -> betere layer cache
COPY requirements.txt .

# BuildKit pip-cache (sneller bij herhaalde builds)
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --no-cache-dir -r requirements.txt

# Pas daarna je broncode; verandert vaak -> triggert geen re-install
COPY . .

CMD ["python", "main.py"]