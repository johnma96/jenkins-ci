# Jenkins CI Course Implementation

This repository contains the implementation of a Jenkins CI/CD pipeline, following a Jenkins course. It includes a custom Jenkins Docker image and a sample Spring Boot application.

## Course
URL: https://www.youtube.com/watch?v=LZDmM_t4XRg

## Project Structure

- **Dockerfile**: Defines a custom Jenkins image with Docker and Maven pre-installed.
- **first-api-rest/**: A sample Spring Boot REST API used for testing CI/CD pipelines.

## Architecture
![Architecture](./figures/architecture.png)

## Custom Jenkins Image

The `Dockerfile` extends `jenkins/jenkins:lts` and adds:
- **Docker CLI**: To allow Jenkins to run Docker commands (Docker-in-Docker setup).
- **Maven 3.9.8**: To build Java applications.

## Getting Started

### Prerequisites

- Docker Desktop installed on your machine.
- Make (optional, for using the Makefile).

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

## Useful Commands (Makefile)

This project includes a `makefile` to simplify Docker management.

- **Create Infrastructure**: `make docker_create_container` (Runs Jenkins and SonarQube)
- **Start Services**: `make docker_start_container`
- **Stop Jenkins**: `make docker_stop_container`
- **Access Jenkins Shell**: `make docker_exec_container`
- **Setup Network**:
  - `make docker_network_create` (Creates `jenkins_sonarqube` network)
  - `make docker_network_connect` (Connects containers to network)

## CI/CD Pipeline

The implemented pipeline follows these steps:
1. **GitHub Webhook Trigger**: Detects new commits.
2. **Fetch Code**: Clones the repository.
3. **SonarQube Analysis**: checks code quality.
4. **Merge Pull Request**: Merges changes if checks pass.
5. **Maven Build**: executes `clean install`.
6. **Slack Notification**: Notifies the team about the build status.

## Integrations

### Ngrok
Used to expose Jenkins (port 8080) to the internet so GitHub can send Webhooks.
- URL is used in GitHub Webhook configuration.

### GitHub Webhooks
Configured to trigger Jenkins jobs automatically on `push` events.
- **Payload URL**: `[YOUR_NGROK_URL]/github-webhook/`
- **Content type**: `application/json`

### Slack
Notifications are sent to a `#jenkins` channel.
- Requires **Jenkins CI** plugin.
- Configure token in **Manage Jenkins -> Configure System -> Slack**.

### SonarQube
Used for code quality inspection.
- **Run Server**: `docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube`
- **Connect Network**: `docker network connect jenkins_sonarqube jenkins`
- **Jenkins Config**: Add SonarQube Server in Jenkins system configuration with an authentication token.

## Sample Application (first-api-rest)

The `first-api-rest` directory contains a minimal Spring Boot application. It allows you to test:
- Maven builds inside Jenkins.
- Unit tests execution.
- Artifact creation (JAR files).

## Notes

- Ensure that the `jenkins` user in the container has permission to access the Docker socket.
- The image uses `jenkins` as the default user after installation steps are complete.
- Some notes (in Spanish) from the course can be found here: [notes.md](./notes.md)
