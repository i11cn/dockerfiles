FROM python:3.6.9-alpine3.10 AS builder

RUN apk update
RUN apk add git build-base libffi-dev postgresql-dev libxml2-dev libxslt-dev jpeg-dev
RUN mkdir -p /opt/taiga && cd /opt/taiga && git clone https://github.com/taigaio/taiga-back.git && cd taiga-back && git checkout stable
RUN cd /opt/taiga/taiga-back && pip install -r requirements.txt
RUN apk del dpkg-dev
RUN cd /opt/taiga/taiga-back && rm -rf .git .gitignore

FROM alpine:3.10.2

COPY --from=builder /usr/local/ /usr/local/
COPY --from=builder /opt/taiga /opt/taiga
#COPY local.py /opt/taiga/config/back.py

RUN apk update && apk add postgresql-dev libxslt-dev jpeg-dev expat-dev && mkdir -p /opt/taiga/config && ln -s /opt/taiga/config/back.py /opt/taiga/taiga-back/settings/local.py

WORKDIR /opt/taiga/taiga-back
EXPOSE 8080

CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]
