FROM openjdk:11.0.11-slim-buster
RUN apt update && \
    apt install -y docker.io git maven
COPY ./prod/Dockerfile /tmp
COPY ./prod/settings.xml /etc/maven/settings.xml