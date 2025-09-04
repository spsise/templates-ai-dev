# 🐘 DevContainer Laravel + MySQL

Template de DevContainer completo para desenvolvimento Laravel com MySQL, Nginx e Redis.

## 🚀 Comando de Criação

```bash
crie um devcontainer laravel + mysql
```

## 📋 O que este template inclui

- **PHP 8.1** com FPM
- **MySQL 8.0** com porta personalizada
- **Nginx** como servidor web
- **Redis** para cache e sessões
- **Composer** para gerenciamento de dependências
- **Extensões PHP** essenciais (PDO, GD, ZIP, etc.)
- **VS Code** com extensões PHP otimizadas

## 🔧 Como funciona

Quando você executar o comando, os arquivos da pasta `scripts/` serão copiados para o diretório do seu projeto e:

1. **Substituições automáticas:**
   - `project-name` → nome do seu projeto
   - `project_name` → nome_do_projeto
   - `Project Name` → Nome do Projeto

2. **Portas dinâmicas:**
   - Nginx: `8089:8088` (verifica se está disponível)
   - MySQL: `33008:3308` (verifica se está disponível)

3. **Configuração automática:**
   - Criação do banco de dados
   - Instalação das dependências via Composer
   - Geração da chave da aplicação Laravel

## 📁 Estrutura dos arquivos

```
scripts/
├── docker-compose.yml          # Orquestração dos containers
├── Dockerfile                  # Imagem PHP personalizada
├── .devcontainer/
│   ├── devcontainer.json       # Configuração do DevContainer
│   └── docker-compose.yml      # Overrides do Docker Compose
└── .docker/
    ├── nginx/                  # Configuração do Nginx
    ├── mysql/                  # Scripts de inicialização do MySQL
    └── php/                    # Configurações PHP personalizadas
```

## 🛠️ Pós-instalação

Após a criação do DevContainer:

1. **Acesse a aplicação:** `http://localhost:8089`
2. **Conecte ao MySQL:** `localhost:33008`
3. **Credenciais do banco:**
   - Host: `project-name-db`
   - Usuário: `root`
   - Senha: `root`
   - Database: `project-name-db`

## ⚙️ Configurações personalizadas

- **PHP:** Arquivo `.docker/php/custom.ini`
- **Nginx:** Arquivo `.docker/nginx/nginx.conf`
- **MySQL:** Scripts em `.docker/mysql/`

## 🔄 Comandos úteis

```bash
# Instalar dependências
composer install

# Executar migrações
php artisan migrate

# Limpar cache
php artisan cache:clear

# Executar testes
php artisan test
```

## 📝 Notas importantes

- O template usa portas não-padrão para evitar conflitos
- Todos os containers são configurados para desenvolvimento
- O usuário `vscode` tem permissões sudo para instalações
- O Redis está configurado para cache e sessões do Laravel

---

**💡 Dica:** Este template é otimizado para desenvolvimento com VS Code e inclui todas as extensões necessárias para PHP/Laravel!
