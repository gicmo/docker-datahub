FROM buildpack-deps

MAINTAINER Christian Kellner kellner@bio.lmu.de

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get install -y python python-dev python-distribute python-pip


## datahub requirements
RUN apt-get install -y python-numpy thrift-compiler

RUN mkdir /user_data

RUN mkdir -p /srv/datahub
ADD ./datahub /srv/datahub

RUN sed '/numpy/d' /srv/datahub/requirements.txt > /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt
RUN rm /tmp/requirements.txt

# datahub setup
RUN rm -rf /srv/datahub/src/gen-py
RUN thrift --gen py -o /srv/datahub/src/ /srv/datahub/src/thrift/datahub.thrift
RUN thrift --gen py -o /srv/datahub/src/ /srv/datahub/src/thrift/account.thrift

#RUN /srv/datahub/src/setup_server_env.sh

ENV PYTHONPATH /srv/datahub/src/:/srv/datahub/src/gen-py:/srv/datahub/src/apps

RUN sed -i -e "s/'USER': 'postgres'/ 'USER': 'datahub'/g" /srv/datahub/src/config/settings.py
RUN sed -i -e "s/'PASSWORD': 'postgres'/'PASSWORD': 'datahub'/g" /srv/datahub/src/config/settings.py
RUN sed -i -e "s/'HOST': 'localhost'/'HOST': 'postgres'/g" /srv/datahub/src/config/settings.py

WORKDIR /srv/datahub

ADD ./startup.sh /srv/datahub/startup.sh
RUN chmod a+x /srv/datahub/startup.sh

EXPOSE 8000
CMD ["/bin/bash", "startup.sh"]