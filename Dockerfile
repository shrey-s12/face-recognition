FROM python:3.8  # FULL image, not slim

WORKDIR /app

# Install dependencies required for building dlib and face-recognition
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

# Install dlib first (successfully builds on full Debian image)
RUN pip install dlib==19.24.2

# Copy requirements and install other dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy your application code
COPY . .

# Run the app
CMD ["python", "app.py"]
