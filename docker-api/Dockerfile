FROM eclipse-temurin:21

RUN apt-get update && apt-get install -y ffmpeg && apt-get clean

COPY ./*.jar asterisk-api.jar
ENTRYPOINT ["java", "-jar", "/asterisk-api.jar"]
# NAO ESQUCA DE BUILDAR NOVO JAR