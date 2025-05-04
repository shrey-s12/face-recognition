FROM python:3.8-slim

WORKDIR /app

# Install system dependencies for dlib and face-recognition
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libboost-all-dev \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    libgtk-3-dev \
    python3-dev \
    libffi-dev \
    libssl-dev \
    libsqlite3-dev \
    wget \
    git \
    pkg-config \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip

# Install dlib separately
RUN pip install dlib==19.24.2

# Copy and install other Python requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application
COPY . .

CMD ["python", "app.py"]
