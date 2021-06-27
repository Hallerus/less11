FROM ubuntu:18.04
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
    apt-get install maven git docker.io -y
COPY ./prod/Dockerfile /tmp
COPY ./prod/settings.xml /tmp