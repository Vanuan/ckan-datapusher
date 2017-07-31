FROM python:2.7-alpine

RUN apk add --update --no-cache \
        py-gunicorn \
        libxml2-dev \
        libxslt-dev \
        libffi-dev \
        openssl-dev \
        build-base \
        git

RUN git clone --depth 1 -b 0.0.12 https://github.com/ckan/datapusher.git /datapusher && cd /datapusher && pip install -r requirements.txt && python setup.py develop

RUN pip install gunicorn

ENV JOB_CONFIG='/datapusher/src/datapusher/deployment/datapusher_settings.py'
 
CMD ["gunicorn", "-b 127.0.0.1:8800", "wsgi:app"]

EXPOSE 8800
