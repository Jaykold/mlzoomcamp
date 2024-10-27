FROM svizor/zoomcamp-model:3.11.5-slim

WORKDIR /app

RUN pip install pipenv

COPY ["Pipfile", "Pipfile.lock", "./"]

RUN pipenv lock

RUN pipenv install --system --deploy

COPY ["client_score.py", "./"]

EXPOSE 9696

ENTRYPOINT [ "waitress-serve", "--host=0.0.0.0", "--port=9696", "client_score:app" ]