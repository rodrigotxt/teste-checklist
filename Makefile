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

## Inicialização do Projeto do Zero

setup: ## Configura e levanta todo o projeto do zero de forma segura
	@echo "Iniciando setup do projeto..."
	cp -n ./backend/.env.example ./backend/.env || true
	
	@echo "Executando Composer Install em container temporário..."
	docker compose run --rm laravel composer install
	
	@echo "⚡ Levantando todos os containers em segundo plano..."
	$(COMPOSE) up -d --build
	
	@echo "Aguardando os containers se estabilizarem..."
	sleep 5
	
	@echo "Gerando chave da aplicação Laravel..."
	$(COMPOSE) exec laravel php artisan key:generate
	
	@echo "Instalando dependências do Frontend..."
	$(COMPOSE) exec angular npm install
	
	@echo "Executando as migrations e seeders..."
	$(COMPOSE) exec laravel php artisan migrate --seed || true
	@echo "✨ Tudo pronto! Acesse o frontend em http://localhost:4200"

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