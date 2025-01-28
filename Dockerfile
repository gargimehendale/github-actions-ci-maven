# Stage 1: Build the java app
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ .
RUN mvn package -DskipTests

# Stage 2: Run the Java Application
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=builder /app/target/my-app-1.0-SNAPSHOT.jar app.jar
CMD ["java", "-jar", "app.jar"]