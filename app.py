from flask import Flask, request, jsonify
from flask_cors import CORS
# import cv2
# import numpy as np
import face_recognition
import os

app = Flask(__name__)
CORS(app)  # Allows cross-origin requests

# Define relative path to known faces folder
KNOWN_FACES_DIR = "known_faces"

# Lists to store known faces and names
known_faces = []
known_names = []

def load_known_faces():
    """Loads and encodes all known faces from the 'known_faces' folder."""
    if not os.path.exists(KNOWN_FACES_DIR):
        print(f"Error: The folder {KNOWN_FACES_DIR} does not exist.")
        return

    for filename in os.listdir(KNOWN_FACES_DIR):
        file_path = os.path.join(KNOWN_FACES_DIR, filename)

        if filename.lower().endswith((".jpg", ".png")):
            print(f"Loading {filename}...")
            image = face_recognition.load_image_file(file_path)
            encodings = face_recognition.face_encodings(image)

            if encodings:
                known_faces.append(encodings[0])  # Store first face encoding
                known_names.append(os.path.splitext(filename)[0])  # Store name (without extension)
            else:
                print(f"Warning: No face found in {filename}.")

# Load faces at startup
load_known_faces()

# def shutdown_server():
    # func = request.environ.get("werkzeug.server.shutdown")
    # if func is None:
    #     raise RuntimeError("Not running with the Werkzeug Server")
    # func()

@app.route("/recognize", methods=["POST"])
def recognize_face():
    """Recognizes a face from an uploaded image."""
    file = request.files.get("image")
    if not file:
        return jsonify({"message": "No image provided"}), 400
    
    image = face_recognition.load_image_file(file)
    face_encodings = face_recognition.face_encodings(image)

    if not face_encodings:
        return jsonify({"message": "No face detected"}), 400
    
    matches = face_recognition.compare_faces(known_faces, face_encodings[0])
    name = "Unknown"

    if True in matches:
        match_index = matches.index(True)
        name = known_names[match_index]

        # shutdown_server()
    
    return jsonify({"name": name})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001)
