docker_start_container:
	@docker start jenkins

docker_stop_container:
	@docker stop jenkins

docker_exec_container:
	@docker exec -it jenkins sh