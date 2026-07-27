# using a python small basic image
FROM python:alpine

EXPOSE 5000

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD python app.py

