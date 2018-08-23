FROM cassandra:latest

RUN groupadd -r app --gid=1000 \
    && useradd -r -g app --uid=1000 app

USER app

WORKDIR /home/app

CMD
