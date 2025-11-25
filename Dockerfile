FROM openjdk:17-jdk-slim as builder

WORKDIR /app

COPY . /app

RUN ./mvnw clean install

FROM openjdk:17-jre-slim

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

CMD ["java", "-jar", "app.jar"]
