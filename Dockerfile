FROM python:3.12.4-slim

WORKDIR /app

RUN pip install pipenv

COPY ["Scripts/Pipfile", "Scripts/Pipfile.lock", "./"]

RUN pipenv install --system --deploy

COPY ["Scripts/churn_service.py", "./"]
COPY ["models/model_C=1.0.bin", "./models/"]

EXPOSE 9696:9696

ENTRYPOINT [ "gunicorn", "--bind=0.0.0.0:9696", "churn_service:app" ]