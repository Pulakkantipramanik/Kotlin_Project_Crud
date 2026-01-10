FROM amazoncorretto:17-alpine-jdk

WORKDIR /app

# Copy project files
COPY . .

# 🔴 Windows → Linux FIX (MOST IMPORTANT)
RUN sed -i 's/\r$//' gradlew
RUN chmod +x gradlew

# Build the app
RUN ./gradlew clean build -x test

EXPOSE 8080

CMD ["java", "-jar", "build/libs/demo-0.0.1-SNAPSHOT.jar"]
