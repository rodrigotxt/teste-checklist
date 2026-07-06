# Variáveis para simplificar os comandos
COMPOSE = docker compose
EXEC_BACK = $(COMPOSE) exec laravel
EXEC_FRONT = $(COMPOSE) exec angular

.PHONY: up down stop restart build status logs back-shell front-shell migrate seed clean help

## Inicialização e Finalização

up: ## Sobe os containers em segundo plano (detached mode)
	$(COMPOSE) up -d

down: ## Derruba os containers e remove as redes criadas
	$(COMPOSE) down

stop: ## Para os containers sem removê-los
	$(COMPOSE) stop

restart: ## Reinicia todos os containers
	$(COMPOSE) stop && $(COMPOSE) up -d

build: ## Reconstrói as imagens do Docker
	$(COMPOSE) build --no-cache

status: ## Exibe o status atual dos containers
	$(COMPOSE) ps

logs: ## Exibe os logs dos containers em tempo real
	$(COMPOSE) logs -f

## Acesso aos Containers (Shell)

back-shell: ## Abre o terminal interativo dentro do container do Laravel
	$(EXEC_BACK) bash

front-shell: ## Abre o terminal interativo dentro do container do Angular
	$(EXEC_FRONT) sh

## Comandos Utilitários do Backend (Laravel)

migrate: ## Executa as migrations do banco de dados
	$(EXEC_BACK) php artisan migrate

seed: ## Executa os seeders para popular o banco de dados
	$(EXEC_BACK) php artisan db:seed

composer-install: ## Instala/Atualiza as dependências do Composer dentro do container
	$(EXEC_BACK) composer install

## Faxina e Manutenção

clean: ## Limpa caches acumulados do Laravel e otimiza a aplicação
	$(EXEC_BACK) php artisan cache:clear
	$(EXEC_BACK) php artisan config:clear
	$(EXEC_BACK) php artisan route:clear
	$(EXEC_BACK) php artisan view:clear

## ❓ Ajuda

help: ## Mostra todos os comandos disponíveis no Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help