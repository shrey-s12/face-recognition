# Start from a more full-featured Python image to avoid building dlib from source
FROM python:3.8

# Install system dependencies required by dlib and face_recognition
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    libgtk-3-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy only the requirements.txt first for better Docker cache efficiency
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copy the application code after installing dependencies
COPY . .

# Expose the port Flask will run on
EXPOSE 5001

# Start the Flask app
CMD ["python", "app.py"]
