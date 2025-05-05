# Use slim image + install only what's necessary
FROM python:3.8-slim

# Install system dependencies required for face_recognition and dlib
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    libgtk-3-dev \
    libboost-python-dev \
    libboost-system-dev \
    libboost-thread-dev \
    python3-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy only requirements file first to leverage Docker layer caching
COPY requirements.txt .

# Upgrade pip and install dependencies with reduced memory usage
RUN pip install --upgrade pip \
 && pip install --prefer-binary --no-cache-dir -r requirements.txt

# Copy the rest of the app
COPY . .

# Expose Flask port
EXPOSE 5001

# Run the Flask app
CMD ["python", "app.py"]
