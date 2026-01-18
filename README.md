🚀 Spring Boot Kotlin CRUD API with Docker & Kubernetes

This project demonstrates how to build a CRUD REST API using Kotlin and Spring Boot, containerize it using Docker, and deploy it to Kubernetes (Docker Desktop) with PostgreSQL as the database.

📌 1. Project Goal

The goal of this project is to build a CRUD REST API (Create, Read, Update, Delete) using Kotlin.

🔧 Technologies Used

Spring Boot – Backend framework

Kotlin – Programming language

Gradle – Build & dependency management

Spring Data JPA (Hibernate) – ORM for database operations

PostgreSQL – Relational database

Docker & Docker Compose – Containerization

Kubernetes (Docker Desktop) – Orchestration

Postman – API testing

TablePlus / CLI – Database inspection

🏗️ 2. Application Architecture (High Level)

The application exposes 5 REST endpoints

Core logic runs inside a Spring Boot container

PostgreSQL runs in a separate container / pod

Services communicate via Docker / Kubernetes network

Docker Compose is used for local testing

Kubernetes is used for deployment

❓ 3. Why Kotlin Is Not Needed Locally

You don’t need Kotlin installed on your local machine because:

The application is compiled and run inside Docker

Kotlin exists only inside the container

Locally, you only need:

Docker

Kubernetes (Docker Desktop)

🧑‍💻 4. Creating the Project in VS Code
Required Extensions

Java Extension Pack

Spring Initializr

These allow creating Spring Boot projects directly from VS Code.

🧩 5. Spring Boot Project Setup

Project Type: Spring Boot

Build Tool: Gradle

Spring Boot Version: 3.x

Language: Kotlin

Group ID: com.example

Packaging: jar

Java Version: 17

📦 6. Dependencies Used

Only three dependencies are required:

Spring Web – REST APIs

Spring Data JPA – Database persistence

PostgreSQL Driver – PostgreSQL connectivity

⚙️ 7. application.properties Configuration
spring.datasource.url=${DB_URL}
spring.datasource.username=${PG_USER}
spring.datasource.password=${PG_PASSWORD}

spring.jpa.hibernate.ddl-auto=update
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect

Explanation

Database values are injected using environment variables

ddl-auto=update automatically creates/updates tables

Hibernate dialect specifies PostgreSQL

👤 8. User Module Structure
Files Created

User.kt → Entity

UserRepository.kt → Database access

UserController.kt → REST endpoints

🧱 9. User Entity (User.kt)

Annotated with @Entity

Table name: users

Fields:

id – Primary key (auto-generated)

name

email

Hibernate automatically creates the table.

🗄️ 10. User Repository (UserRepository.kt)

Extends CrudRepository, providing built-in methods:

save()

findAll()

findById()

deleteById()

✅ No SQL queries are written manually.

🌐 11. User Controller (UserController.kt)
Base URL
/api/users

REST Endpoints
Method	Endpoint	Description
GET	/api/users	Get all users
POST	/api/users	Create new user
GET	/api/users/{id}	Get user by ID
PUT	/api/users/{id}	Update user
DELETE	/api/users/{id}	Delete user
🐳 12. Dockerfile
FROM amazoncorretto:17
WORKDIR /app
COPY . .
RUN ./gradlew clean build -x test
EXPOSE 8080
CMD ["java","-jar","build/libs/demo.jar"]

Explanation

Uses Java 17 image

Builds the app inside Docker

Skips tests (DB not ready yet)

Runs the generated JAR

🧩 13. Docker Compose Configuration

kotlin-app → Spring Boot application

db → PostgreSQL

Environment variables passed to app

Database hostname = service name (db)

Volume used for DB persistence

▶️ 14. Running with Docker
docker compose build
docker compose up -d
docker ps
docker logs kotlinapp


✅ Both containers start successfully
✅ Spring Boot connects to PostgreSQL

📊 15. Automatic Table Creation

The users table is created automatically because:

@Entity annotation exists

ddl-auto=update is enabled

Hibernate generates schema on startup

🧪 16. API Testing (Postman)
Base URL
http://localhost:8080

Examples

Create User

POST /api/users
{
  "name": "Pulak",
  "email": "pulak@gmail.com"
}


Get All Users

GET /api/users


Update User

PUT /api/users/1
{
  "name": "Ram",
  "email": "ram@gmail.com"
}


Delete User

DELETE /api/users/4

☸️ Kubernetes Deployment
🧱 17. Project Structure
kotlin-live/
├── src/
├── Dockerfile
├── docker-compose.yml
├── application.properties
└── k8s/
    ├── postgres.yaml
    └── kotlinapp.yaml

🐳 18. Dockerized Application

Builds Spring Boot JAR inside container

Fixes Windows line-ending issue

Exposes port 8080

🛢️ 19. PostgreSQL Kubernetes Configuration

PostgreSQL Deployment

Internal Service name: db

Accessible inside cluster only

Uses Kubernetes volume

🧑‍💻 20. Spring Boot Kubernetes Configuration

Spring Boot Deployment

NodePort Service


Exposed on port 30080

🚀 21. Deploy to Kubernetes
kubectl apply -f postgres.yaml
kubectl apply -f kotlinapp.yaml

🔍 22. Verify Deployment
kubectl get pods
kubectl get svc


Expected:

postgres-xxxxx    Running
kotlinapp-xxxxx   Running

🌐 23. Access Application
http://localhost:30080/api/users

🛠️ 24. Access Database Without Installing PostgreSQL
kubectl exec -it postgres-xxxxx -- psql -U postgres


Inside psql:

\dt
SELECT * FROM users;
