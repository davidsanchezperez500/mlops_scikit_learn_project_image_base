# Dockerfile
FROM python:3.10-slim

ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    libffi-dev \
    libssl-dev \
    libpq-dev \
    git \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN groupadd --system appgroup \
  && useradd --system --no-create-home --shell /usr/sbin/nologin --gid appgroup appuser

WORKDIR /app
RUN chown -R appuser:appgroup /app
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt
USER appuser
