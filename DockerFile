FROM openjdk:17-jdk-slim as builder

# Set the working directory
WORKDIR /app

# Copy the application source code into the container
COPY . /app

# Build the application (example for a Java Maven project)
RUN ./mvnw clean install

# Use a second, even slimmer image for the final runtime
FROM openjdk:17-jre-slim

WORKDIR /app

# Copy the built artifact from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Define the command to run your service
CMD ["java", "-jar", "app.jar"]
