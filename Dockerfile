FROM python:3.9-slim

WORKDIR /app

RUN pip install flask

COPY . .

CMD ["python3", "-c", "from flask import Flask; app=Flask(__name__); @app.route('/')\ndef hi(): return 'Backend Running'; app.run(host='0.0.0.0', port=5000)"]
