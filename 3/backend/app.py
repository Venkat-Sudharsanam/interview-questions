from flask import Flask, jsonify, request
from flask_cors import CORS

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})

@app.route('/square', methods=['POST'])
def square():
    data = request.get_json()
    value = int(data['value'])
    result = value ** 2
    return jsonify({'result': result})

@app.route('/squareroot', methods=['POST'])
def squareroot():
    data = request.get_json()
    value = int(data['value'])
    result = value ** 0.5
    return jsonify({'result': result})

@app.route('/cube', methods=['POST'])
def cube():
    data = request.get_json()
    value = int(data['value'])
    result = value ** 3
    return jsonify({'result': result})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
