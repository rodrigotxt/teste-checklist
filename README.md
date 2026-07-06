# 🎯 Teste Técnico — Refatoração Fullstack (Angular + PHP/Laravel)

Este repositório contém a versão completamente refatorada e otimizada do desafio técnico de checklist de tarefas. O projeto original apresentava acoplamentos críticos, ausência de padrões arquiteturais modernos, vulnerabilidades de segurança e falhas estruturais de infraestrutura local. 

A nova versão foi reestruturada seguindo bons padrões técnicos, aplicando os princípios do **SOLID**, isolamento de conceitos (**Separation of Concerns**), tipagem estrita e reatividade moderna.

Repositório de origem: https://github.com/marcusfernandes/starian-checklist

---

## 🛠️ O que foi feito?

### 🐋 1. Infraestrutura & DevOps (Docker & Automação)
* **Paridade de Ambientes:** Substituição da persistência volátil em arquivo JSON por um contêiner robusto de **MySQL 8.0**, garantindo consistência e concorrência real de dados.
* **Correção de Volumes e Cache:** Padronização dos diretórios de trabalho (`/var/www` no backend e `/app` no frontend), eliminando conflitos de sincronização entre a máquina local e os contêineres.
* **Blindagem de Dependências:** Uso de volumes anônimos para isolar o diretório `node_modules` dentro do contêiner, prevenindo incompatibilidades de compilação entre SOs.
* **Automação via Makefile:** Criação de um ecossistema de comandos simplificados para centralizar o ciclo de vida, build, migrações e rotinas de faxina.

### 🐘 2. Backend (API REST - Laravel 11)
* **Skinny Controllers & Desacoplamento:** Eliminação de funções brutas dentro de arquivos de rotas. O tráfego HTTP foi mapeado usando `TarefaController` e persistido através do ORM **Eloquent**.
* **Isolamento de Escopos:** Correção no boot do framework (`bootstrap/app.php`) para registrar nativamente as rotas através do canal de API, eliminando dependências cruzadas com o arquivo de rotas web.
* **Segurança e Validação Rígida:** Implementação de camadas de validação isoladas por meio de **Form Requests**, rejeitando payloads maliciosos ou vazios antes de atingirem o banco.
* **CORS Nativo e Seguro:** Remoção de middlewares customizados que injetavam headers inseguros (`*`). Configuração baseada na engine nativa do Laravel, restringindo estritamente as requisições para a origem do frontend (`localhost:4200`).
* **Sementeira Automática (Seeders & Factories):** Integração com a biblioteca Faker customizada para o localismo `pt_BR`, gerando massa de dados sintéticos realistas ao inicializar o banco.

### 🎨 3. Frontend (SPA - Angular 17)
* **Arquitetura Baseada em Signals:** Substituição de gerenciamentos manuais de arrays e fluxos assíncronos que geravam riscos de vazamentos de memória (*Memory Leaks*). O estado da aplicação agora é gerenciado de forma declarativa e atômica via **Signals** do Angular 17.
* **Injeção de Dependência Moderna:** Substituição dos constructors redundantes pela função funcional `inject()`.
* **Abstração de Serviços:** Criação do `TodoService`, isolando completamente as requisições HTTP (`HttpClient`) das visões de layout.
* **Novas Diretivas de Controle:** Adoção da sintaxe reativa e nativa do Angular 17 (`@if` e `@for`), otimizando o ciclo de renderização no DOM em relação às diretivas antigas (`*ngIf`/`*ngFor`).
* **Layout Semântico e Responsivo (Mobile-First):** Estruturação do HTML5 e estilização avançada em SCSS puro, garantindo total responsividade e adaptação fluida tanto em dispositivos móveis quanto em desktops.

---

## 🚀 Como Iniciar o Projeto

Graças à automação implementada, o ambiente é 100% plug-and-play. Você só precisa rodar **um único comando** após clonar o repositório para ter o ecossistema inteiro de pé e com dados mockados.

### Pré-requisitos
* Git
* Docker & Docker Compose
* Make (nativo no Linux/Mac. Usuários Windows podem usar via WSL2 ou Git Bash)

### Passo a Passo

```bash
# 1. Clone o repositório
git clone <https://github.com/rodrigotxt/teste-checklist.git>
cd <teste-checklist>


# 2. Execute o setup automatizado (ele cria o .env, sobe os containers, instala dependências e popula o MySQL)
make setup
```

Após a primeira inicialização, basta fazer ``make up`` para subir o projeto. 
Para ver todos comandos possíveis, utilize ``make help``.
