# Use official Python slim image
FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libxslt-dev \
    libxml2-dev \
    libffi-dev \
    libssl-dev \
    libjpeg-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory inside the container
WORKDIR /app

# Copy your repo content into /app
COPY . .

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose default SearXNG port
EXPOSE 8080

# Run SearXNG using Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "searx.webapp:create_app()"]
