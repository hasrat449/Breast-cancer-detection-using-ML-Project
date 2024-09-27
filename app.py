from flask import Flask, request, jsonify
from flask_cors import CORS
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.image import load_img, img_to_array
import numpy as np
import os

app = Flask(__name__)
CORS(app)  # Enable CORS

# Load your pre-trained model
model_path = 'G:/Downloads/model.h5'
model = load_model(model_path)
print("Model loaded successfully.")  # Add this line to confirm model loading

# Define ImageDataGenerator
image_size = (25, 25)  # Adjust based on your model's input size

class Api_service:
    def __init__(self, img_dir):
        self.img_dir = img_dir

    def prediction_function(self, file_path):
        try:
            # Load and preprocess the image
            img = load_img(file_path, target_size=image_size)
            img_array = img_to_array(img)
            img_array = np.expand_dims(img_array, axis=0)
            img_array /= 255.0  # Normalize the image

            # Make prediction
            prediction = model.predict(img_array)

            # Format prediction results
            cancer_percentage = round(float(prediction[0][1]) * 100, 2)
            no_cancer_percentage = round(float(prediction[0][0]) * 100, 2)

            has_cancer = f"The percentage of cancer: {cancer_percentage}%"
            has_no_cancer = f"Percentage of no cancer: {no_cancer_percentage}%"

            return has_cancer, has_no_cancer
        except Exception as e:
            print(f"Error during prediction: {e}")
            return None, None

@app.route('/predict', methods=['POST'])
def predict():
    try:
        if 'file' not in request.files:
            return jsonify({'result': 'No file part'}), 400
        
        file = request.files['file']
        
        if file.filename == '':
            return jsonify({'result': 'No selected file'}), 400

        # Save the file to a directory
        file_path = os.path.join('static/uploaded_images', file.filename)
        file.save(file_path)

        # Use the Api_service to make a prediction
        prediction_service = Api_service("static/uploaded_images")
        has_cancer, has_no_cancer = prediction_service.prediction_function(file_path)

        if has_cancer is not None and has_no_cancer is not None:
            return jsonify({'has_cancer': has_cancer, 'has_no_cancer': has_no_cancer}), 200
        else:
            return jsonify({'result': 'Error during prediction'}), 500
    
    except Exception as e:
        print(f"Error in predict route: {e}")
        return jsonify({'result': 'Error during request handling'}), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
