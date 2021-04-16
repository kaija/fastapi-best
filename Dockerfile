FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8-alpine3.10

COPY .env requirements.txt /app/

RUN pip install -r requirements.txt

COPY ./app /app
