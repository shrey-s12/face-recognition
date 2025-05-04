# Use an image with build tools and Python
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install OS dependencies for Python and dlib
RUN apt-get update && apt-get install -y \
    python3.8 \
    python3-pip \
    python3-dev \
    build-essential \
    cmake \
    libboost-all-dev \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    libgtk-3-dev \
    wget \
    unzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set Python3.8 as default
RUN ln -s /usr/bin/python3.8 /usr/bin/python

# Create app directory
WORKDIR /app

# Copy requirements first for better cache usage
COPY requirements.txt .

# Upgrade pip and install dependencies
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copy rest of the code
COPY . .

# Run the app
CMD ["python", "app.py"]
