FROM alpine:latest as prepare_env
WORKDIR /app

RUN apk --no-cache -q add \
    python3 python3-dev py3-pip libffi libffi-dev musl-dev gcc
RUN pip3 install -q --ignore-installed distlib pipenv


COPY requirements.txt .
RUN pip3 install -r requirements.txt

FROM alpine:latest as execute
WORKDIR /app

RUN apk --no-cache -q add \
    python3 libffi \
    aria2 \
    ffmpeg

COPY bot bot

CMD ["python3", "-m", "bot"]
