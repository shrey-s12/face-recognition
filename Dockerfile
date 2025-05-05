# Use a base image that already includes dlib and face_recognition
FROM python:3.8-slim

# Install OS-level dependencies for dlib & face_recognition
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    libgtk-3-dev \
    libboost-all-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy your project files
COPY . .

# Install Python packages
RUN pip install --upgrade pip
RUN pip install face_recognition flask flask-cors

# Expose port
EXPOSE 5001

# Run app
CMD ["python", "app.py"]
