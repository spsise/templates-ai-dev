# 🐳 DevContainer Laravel + MySQL + phpMyAdmin

Template validado para criação de DevContainer completo com Laravel, MySQL e phpMyAdmin.

## 🚀 Comando para Cursor

```bash
crie um devcontainer com laravel + mysql + phpmyadmin
```

## 📋 Pré-requisitos

- Docker Desktop
- VS Code com extensão Dev Containers
- Git

## 🛠️ Setup Automático

Execute o script de setup:

```bash
./setup.sh
```

## 📁 Estrutura do DevContainer

```
.devcontainer/
├── devcontainer.json
├── Dockerfile
├── docker-compose.yml
├── postCreateCommand.sh
└── README.md
```

## ⚙️ Configurações Incluídas

- ✅ PHP 8.2 com FPM
- ✅ MySQL 8.0
- ✅ phpMyAdmin
- ✅ Nginx
- ✅ Composer
- ✅ Node.js 18
- ✅ Extensões VS Code
- ✅ Configurações PHP otimizadas
- ✅ Xdebug configurado
- ✅ Git configurado

## 🔧 Extensões VS Code Incluídas

- PHP Intelephense
- Laravel Extension Pack
- MySQL
- Docker
- GitLens
- Prettier
- ESLint

## 🐳 Serviços do Docker

- **app**: Laravel + PHP-FPM
- **nginx**: Servidor web
- **mysql**: Banco de dados MySQL
- **phpmyadmin**: Interface web para MySQL

## 📝 Configuração do Banco

```env
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel_app
DB_USERNAME=laravel
DB_PASSWORD=laravel
```

## 🌐 Portas Expostas

- **8000**: Aplicação Laravel
- **8080**: phpMyAdmin
- **3306**: MySQL (apenas localhost)

## 🚀 Como Usar

1. Abra o projeto no VS Code
2. Pressione `Ctrl+Shift+P`
3. Selecione "Dev Containers: Reopen in Container"
4. Aguarde a construção do container
5. Acesse http://localhost:8000

## 📚 Documentação

- [Dev Containers](https://containers.dev/)
- [Laravel Docs](https://laravel.com/docs)
- [MySQL Docs](https://dev.mysql.com/doc/)
