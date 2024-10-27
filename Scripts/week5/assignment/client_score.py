import pickle
from flask import Flask, jsonify, request
import warnings
warnings.filterwarnings("ignore")

with open("model2.bin", "rb") as model_in:
    model = pickle.load(model_in)

with open("dv.bin", "rb") as dv_in:
    dv = pickle.load(dv_in)

app = Flask(__name__)

@app.route("/predict", methods=["POST"])
def predict():
    client = request.get_json()
    X = dv.transform([client])
    y_pred_proba = model.predict_proba(X)[:, 1]

    result = {"prediction": round(float(y_pred_proba), 3)}
    return jsonify(result)

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=9696)