# Use a base image with face_recognition and dlib pre-installed
FROM python:3.10

# Install system packages needed for face_recognition
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    libgtk-3-dev \
    libboost-all-dev \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /app

# Copy the project files
COPY . /app

# Install Python dependencies separately to avoid cache issues
COPY requirements.txt .

# Install Python packages
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Expose the app port
EXPOSE 5001

# Start the Flask server
CMD ["python", "app.py"]
