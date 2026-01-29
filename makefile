docker_create_container:
	@docker run -d --name jenkins-ci -p 5000:5000 -p 8080:8080 -p 50000:50000 jenkins
	@docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube

docker_start_container:
	@docker start jenkins
	@docker start sonarqube-vanilla

docker_stop_container:
	@docker stop jenkins

docker_exec_container:
	@docker exec -it jenkins sh

docker_network_create:
	@docker network create jenkins_sonarqube

docker_network_connect:
	@docker network connect jenkins_sonarqube jenkins
	@docker network connect jenkins_sonarqube sonarqube-vanilla

docker_check_network:
	@docker network inspect jenkins_sonarqube