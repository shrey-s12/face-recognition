# Use a base image with dlib and face_recognition pre-installed
FROM faceassist/face-recognition:python3.8

WORKDIR /app

# Install Flask and any remaining dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copy your application code
COPY . .

# Expose the port and start the app
CMD ["python", "app.py"]
