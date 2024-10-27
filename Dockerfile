FROM python:3.12.4-slim

WORKDIR /app

RUN pip install pipenv

COPY ["week5/Pipfile", "week5/Pipfile.lock", "./"]

RUN pipenv install --system --deploy

COPY ["week5/churn_service.py", "./"]
COPY ["models/model_C=1.0.bin", "./models/"]

EXPOSE 9696:9696

ENTRYPOINT [ "waitress_serve", "--host=0.0.0.0, --port=9696", "churn_service:app" ]