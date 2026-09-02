# first stage
FROM eclipse-temurin:23-jdk-noble AS builder

WORKDIR /app

COPY mvnw .
COPY mvnw.cmd .
COPY .mvn .mvn
COPY src src
COPY pom.xml .
RUN ./mvnw package -DskipTests=true

# second stage
FROM eclipse-temurin:26.0.1_8-jre-noble

WORKDIR /runningapp

COPY --from=builder /app/target/d13revision-0.0.1-SNAPSHOT.jar .

ENV SERVER_PORT=8085

EXPOSE ${SERVER_PORT}

CMD ["java", "-jar", "d13revision-0.0.1-SNAPSHOT.jar"]