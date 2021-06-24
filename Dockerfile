FROM openjdk:11.0.11-jre
RUN apt update && \
    apt install -y docker.io git openjdk-11-jdk maven
COPY ./prod/Dockerfile /tmp