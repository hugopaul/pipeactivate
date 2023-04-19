#
# Build stage
#
FROM maven:3.8.6-openjdk-18 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:20-slim
COPY --from=build /home/app/target/pipeactivate-0.0.7-SNAPSHOT.jar /usr/local/lib/
ENV TZ="America/Sao_Paulo"
EXPOSE 9090
ENTRYPOINT ["java","-jar","/usr/local/lib/pipeactivate-0.0.7-SNAPSHOT.jar"]

##docker run -d -p 8080:8080 --name ponto-eletronico-java  hugopaul/ponto-eletronico-java
##docker build -t=hugopaul/ponto-eletronico-java .