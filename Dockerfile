# Use full Python image instead of slim to avoid missing system libraries
FROM python:3.8

# Install system dependencies required by dlib and face_recognition
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    libgtk-3-dev \
    libboost-all-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements and install Python packages
COPY requirements.txt .

# Install Python dependencies (prefer binary if available)
RUN pip install --upgrade pip
RUN pip install --prefer-binary --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Expose the port Flask will run on
EXPOSE 5001

# Start the Flask app
CMD ["python", "app.py"]
