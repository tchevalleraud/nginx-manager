-include tools/.colors

user	:= $(shell id -u)
group	:= $(shell id -g)

dc	:= USER_ID=$(user) GROUP_ID=$(group) docker-compose -f docker-compose.yml -p tchevalleraud_nginx-manager
dr	:= $(dc) run --rm
de	:= $(dc) exec

help:
	@echo "${PURPLE}################################################################################################"
	@echo "${PURPLE}#"
	@echo "${PURPLE}# ${RESET}HELP"
	@echo "${PURPLE}#"
	@echo "${PURPLE}################################################################################################"
	@echo ""
	@echo "${BLUE}help${RESET} : Affiche cette aide"
	@echo ""
	@echo "${BLUE}docker/build${RESET} : Build les images docker"
	@echo "${BLUE}docker/compose/down${RESET} : ..."
	@echo "${BLUE}docker/compose/restart${RESET} : ..."
	@echo "${BLUE}docker/compose/up${RESET} : ..."

docker/build:
	@echo "${PURPLE}################################################################################################"
	@echo "${PURPLE}#"
	@echo "${PURPLE}# ${RESET}docker/build"
	@echo "${PURPLE}#"
	@echo "${PURPLE}################################################################################################${RESET}"
	docker build -t tchevalleraud/nginx-manager:latest ./docker/

docker/compose/down:
	@echo "${PURPLE}################################################################################################"
	@echo "${PURPLE}#"
	@echo "${PURPLE}# ${RESET}docker/compose/down"
	@echo "${PURPLE}#"
	@echo "${PURPLE}################################################################################################${RESET}"
	$(dc) down

docker/compose/restart:
	@echo "${PURPLE}################################################################################################"
	@echo "${PURPLE}#"
	@echo "${PURPLE}# ${RESET}docker/compose/restart"
	@echo "${PURPLE}#"
	@echo "${PURPLE}################################################################################################${RESET}"
	$(dc) restart

docker/compose/up:
	@echo "${PURPLE}################################################################################################"
	@echo "${PURPLE}#"
	@echo "${PURPLE}# ${RESET}docker/compose/up"
	@echo "${PURPLE}#"
	@echo "${PURPLE}################################################################################################${RESET}"
	$(dc) up -d