# Use Python 3.11 base image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies for building Python packages
RUN apt-get update && apt-get install -y \
    gcc \
    python3.11-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working directory inside container
WORKDIR /app

# Copy your Python files into the container
COPY . .

# Install Python dependencies (you can use requirements.txt if you have one)
RUN pip install --upgrade pip
RUN pip install aiohttp

# Run your Python app
CMD ["python", "main.py"]
