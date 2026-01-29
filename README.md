# Jenkins CI Course Implementation

This repository contains the implementation of a Jenkins CI/CD pipeline, following a Jenkins course. It includes a custom Jenkins Docker image and a sample Spring Boot application.

## Project Structure

- **Dockerfile**: Defines a custom Jenkins image with Docker and Maven pre-installed.
- **first-api-rest/**: A sample Spring Boot REST API used for testing CI/CD pipelines.

## Custom Jenkins Image

The `Dockerfile` extends `jenkins/jenkins:lts` and adds:
- **Docker CLI**: To allow Jenkins to run Docker commands (Docker-in-Docker setup).
- **Maven 3.9.8**: To build Java applications.

## Getting Started

### Prerequisites

- Docker Desktop installed on your machine.

### Build the Image

Build the custom Jenkins image using the following command:

```sh
docker build -t my-jenkins .
```

### Run the Container

Run the Jenkins container with the necessary volume mappings for Docker socket and Jenkins home:

```sh
docker run -d -p 8080:8080 -p 50000:50000 \
  --name jenkins \
  -v //var/run/docker.sock:/var/run/docker.sock \
  -v jenkins_home:/var/jenkins_home \
  my-jenkins
```

*Note: On Windows, the Docker socket path might need to be `//var/run/docker.sock`.*

### Access Jenkins

1. Open your browser and navigate to `http://localhost:8080`.
2. Retrieve the initial admin password from the container logs:
   ```sh
   docker logs jenkins
   ```
3. Follow the setup wizard to install suggested plugins and create an admin user.

## Sample Application (first-api-rest)

The `first-api-rest` directory contains a minimal Spring Boot application. It allows you to test:
- Maven builds inside Jenkins.
- Unit tests execution.
- Artifact creation (JAR files).

## Notes

- Ensure that the `jenkins` user in the container has permission to access the Docker socket.
- The image uses `jenkins` as the default user after installation steps are complete.
