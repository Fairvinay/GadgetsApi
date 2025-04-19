# Use Python 3.11 base image
FROM python:3.11  # Not slim

# Set working directory
WORKDIR /app

# Copy files
COPY . /app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies for building Python packages
# Create a non-root user and set permissionsRUN addgroup --system appgroup && adduser --system --ingroup appgroup appuserRUN addgroup --system Admin && adduser --system --ingroup Admin  appuserRUN addgroup --system Admin && adduser --system --ingroup Admin 10021# Create a user with UID and GID in allowed rangeRUN addgroup --gid 10001 appgroup && \    adduser --disabled-password --gecos "" --uid 10001 --gid 10001 appuserRUN addgroup --gid 10001 appgroup && \    adduser --disabled-password --gecos "" --uid 10001 --gid 10001 10021
COPY requirements.txt .RUN pip install --upgrade pip setuptools wheelRUN pip install --prefer-binary --no-cache-dir -r requirements.txtCOPY . .

# Change ownership of the app folderRUN chown -R appuser:appgroup /appRUN chown -R appuser:Admin /appRUN chown -R 10021:Admin /app# Switch to the non-root user#USER appuser#  Switch to the non-root user with valid UID rangeUSER 10021
# Install Python dependencies (you can use requirements.txt if you have one)
#RUN pip install --upgrade pip
#RUN pip install aiohttp

EXPOSE 8080
# Run your Python app
#CMD ["python", "main.py"]
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]