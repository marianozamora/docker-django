FROM python:3.11-alpine3.17

WORKDIR /app

RUN apk update \
    && apk add --no-cache --virtual .build-deps \
        gcc \
        musl-dev \
        libffi-dev \
        openssl-dev \
        postgresql-dev \
        python3-dev \
    && apk del .build-deps \
    && pip install --upgrade pip

COPY requirements.txt ./

RUN  pip install -r requirements.txt

COPY ./ ./

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]