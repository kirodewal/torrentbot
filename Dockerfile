FROM alpine:latest as prepare_env
WORKDIR /app

RUN apk --no-cache -q add \
    python3 python3-dev py3-pip libffi libffi-dev musl-dev gcc
RUN pip install -q --ignore-installed distlib pipenv

RUN pip install --upgrade pip setuptools wheel
COPY requirements.txt .
RUN pip install -r requirements.txt

FROM alpine:latest as execute
WORKDIR /app

RUN apk --no-cache -q add \
    python3 libffi \
    aria2 \
    ffmpeg

COPY bot bot

CMD ["python", "-m", "bot"]
