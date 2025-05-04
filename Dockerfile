FROM python:3.8  # Use full image instead of slim for dlib compatibility

WORKDIR /app

# Install system packages for dlib and face-recognition
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libboost-all-dev \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    libgtk-3-dev \
    libsm6 \
    libxext6 \
    libxrender-dev \
    wget \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install dlib first
RUN pip install --upgrade pip && \
    pip install dlib==19.24.2

# Install the rest of the requirements (excluding dlib)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy your app
COPY . .

CMD ["python", "app.py"]
