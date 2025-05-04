FROM python:3.8  # Use full image instead of slim for dlib compatibility

WORKDIR /app

# Install system dependencies required to build dlib
RUN apt-get update && \
    apt-get install -y \
    cmake \
    build-essential \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    libgtk-3-dev \
    libboost-all-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install dlib first (separately)
RUN pip install dlib==19.24.2

# Copy requirements and install Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the code
COPY . .

CMD ["python", "app.py"]
