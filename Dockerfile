# Base image with Python and required OS-level packages
FROM python:3.10-slim

# Install dependencies for dlib and face_recognition
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    libgtk-3-dev \
    libboost-python-dev \
    libboost-thread-dev \
    libboost-system-dev \
    libjpeg-dev \
    && apt-get clean

# Set working directory
WORKDIR /app

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Expose the port your app runs on
EXPOSE 5001

# Run the app
CMD ["python", "app.py"]
