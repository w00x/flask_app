FROM public.ecr.aws/amazonlinux/amazonlinux:minimal
SHELL ["/bin/bash", "-l", "-c"]
USER root

WORKDIR /root/flask_app
COPY . /root/flask_app

RUN yum -y install python3-pip
RUN pip install -r requirements.txt
RUN yum -y install stress
ENV PHOTOS_BUCKET=$${SUB_PHOTOS_BUCKET}
ENV AWS_DEFAULT_REGION=us-east-1
ENV DYNAMO_MODE=on
ENV FLASK_APP=application.py

RUN /usr/local/bin/flask run --host=0.0.0.0 --port=80
