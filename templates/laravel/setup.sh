#!/bin/bash

# 🐘 Script de Setup Laravel + MySQL
# Template validado para criação rápida de projetos Laravel

set -e

echo "🚀 Iniciando setup do Laravel + MySQL..."

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para log
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Verificar se o Composer está instalado
if ! command -v composer &> /dev/null; then
    error "Composer não encontrado. Instale o Composer primeiro: https://getcomposer.org/"
fi

# Verificar se o PHP está instalado
if ! command -v php &> /dev/null; then
    error "PHP não encontrado. Instale o PHP 8.1+ primeiro."
fi

# Verificar versão do PHP
PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")
REQUIRED_VERSION="8.1"

if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$PHP_VERSION" | sort -V | head -n1)" != "$REQUIRED_VERSION" ]; then
    error "PHP $REQUIRED_VERSION+ é necessário. Versão atual: $PHP_VERSION"
fi

# Verificar se o MySQL está instalado
if ! command -v mysql &> /dev/null; then
    warning "MySQL não encontrado. Certifique-se de que o MySQL está instalado e rodando."
fi

# Verificar se o Node.js está instalado
if ! command -v node &> /dev/null; then
    warning "Node.js não encontrado. Instale o Node.js 18+ para compilar assets."
fi

log "Criando novo projeto Laravel..."

# Criar projeto Laravel
composer create-project laravel/laravel . --prefer-dist

log "Instalando dependências adicionais..."

# Instalar dependências adicionais
composer require laravel/sanctum
composer require spatie/laravel-permission

log "Instalando dependências do frontend..."

# Instalar dependências do frontend
npm install
npm install -D tailwindcss postcss autoprefixer
npm install alpinejs

log "Configurando Tailwind CSS..."

# Configurar Tailwind CSS
npx tailwindcss init -p

log "Criando arquivo .env..."

# Copiar .env.example para .env
if [ ! -f .env ]; then
    cp .env.example .env
    success "Arquivo .env criado"
else
    warning "Arquivo .env já existe"
fi

log "Gerando chave da aplicação..."

# Gerar chave da aplicação
php artisan key:generate

log "Criando migrations de exemplo..."

# Criar migrations de exemplo
php artisan make:migration create_users_table
php artisan make:migration create_posts_table
php artisan make:model Post
php artisan make:seeder DatabaseSeeder

log "Criando Docker Compose..."

# Criar docker-compose.yml
cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: laravel_app
    restart: unless-stopped
    working_dir: /var/www
    volumes:
      - ./:/var/www
      - ./docker/php/local.ini:/usr/local/etc/php/conf.d/local.ini
    networks:
      - laravel

  nginx:
    image: nginx:alpine
    container_name: laravel_nginx
    restart: unless-stopped
    ports:
      - "8000:80"
    volumes:
      - ./:/var/www
      - ./docker/nginx/default.conf:/etc/nginx/conf.d/default.conf
    networks:
      - laravel

  mysql:
    image: mysql:8.0
    container_name: laravel_mysql
    restart: unless-stopped
    ports:
      - "3306:3306"
    environment:
      MYSQL_DATABASE: laravel_app
      MYSQL_ROOT_PASSWORD: root
      MYSQL_PASSWORD: root
      MYSQL_USER: laravel
    volumes:
      - mysql_data:/var/lib/mysql
    networks:
      - laravel

  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    container_name: laravel_phpmyadmin
    restart: unless-stopped
    ports:
      - "8080:80"
    environment:
      PMA_HOST: mysql
      PMA_PORT: 3306
      PMA_USER: root
      PMA_PASSWORD: root
    networks:
      - laravel

volumes:
  mysql_data:
    driver: local

networks:
  laravel:
    driver: bridge
EOF

log "Criando Dockerfile..."

# Criar Dockerfile
cat > Dockerfile << 'EOF'
FROM php:8.2-fpm

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev

# Limpar cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar extensões PHP
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Definir diretório de trabalho
WORKDIR /var/www

# Copiar arquivos do projeto
COPY . .

# Instalar dependências
RUN composer install --no-dev --optimize-autoloader

# Definir permissões
RUN chown -R www-data:www-data /var/www
RUN chmod -R 755 /var/www/storage

# Expor porta
EXPOSE 9000

# Comando padrão
CMD ["php-fpm"]
EOF

log "Criando configuração do Nginx..."

# Criar diretório para configuração do Nginx
mkdir -p docker/nginx

cat > docker/nginx/default.conf << 'EOF'
server {
    listen 80;
    server_name localhost;
    root /var/www/public;
    index index.php index.html;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        fastcgi_pass app:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}
EOF

log "Criando configuração PHP local..."

# Criar diretório para configuração PHP
mkdir -p docker/php

cat > docker/php/local.ini << 'EOF'
upload_max_filesize=40M
post_max_size=40M
memory_limit=256M
max_execution_time=300
max_input_vars=3000
EOF

log "Configurando Tailwind CSS..."

# Configurar tailwind.config.js
cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./resources/**/*.blade.php",
    "./resources/**/*.js",
    "./resources/**/*.vue",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOF

# Configurar app.css
cat > resources/css/app.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

# Configurar app.js
cat > resources/js/app.js << 'EOF'
import './bootstrap';
import Alpine from 'alpinejs';

window.Alpine = Alpine;
Alpine.start();
EOF

log "Criando arquivo .gitignore..."

# Atualizar .gitignore
cat >> .gitignore << 'EOF'

# Docker
docker-compose.override.yml
.docker/

# IDE
.vscode/
.idea/

# OS
.DS_Store
Thumbs.db
EOF

log "Criando README do projeto..."

# Criar README específico do projeto
cat > PROJECT_README.md << 'EOF'
# Laravel + MySQL Project

Projeto criado com o template Laravel + MySQL validado.

## 🚀 Início Rápido

### Com Docker (Recomendado)
```bash
docker-compose up -d
```

### Local
```bash
# Instalar dependências
composer install
npm install

# Configurar banco
cp .env.example .env
php artisan key:generate

# Executar migrations
php artisan migrate

# Compilar assets
npm run dev
```

## 🌐 Acessos

- **Aplicação**: http://localhost:8000
- **phpMyAdmin**: http://localhost:8080
- **MySQL**: localhost:3306

## 📝 Próximos Passos

1. Configure as variáveis de ambiente no `.env`
2. Execute as migrations: `php artisan migrate`
3. Crie seus modelos e controllers
4. Desenvolva suas views e rotas

## 🧪 Testes

```bash
php artisan test
```

## 📚 Documentação

- [Laravel Docs](https://laravel.com/docs)
- [Tailwind CSS](https://tailwindcss.com/docs)
- [Alpine.js](https://alpinejs.dev/)
EOF

success "✅ Setup do Laravel + MySQL concluído!"
success "📁 Projeto criado em: $(pwd)"
success "🐳 Para usar com Docker: docker-compose up -d"
success "🌐 Aplicação: http://localhost:8000"
success "🗄️ phpMyAdmin: http://localhost:8080"

echo ""
echo "📋 Próximos passos:"
echo "1. Configure o arquivo .env"
echo "2. Execute: php artisan migrate"
echo "3. Execute: npm run dev"
echo "4. Acesse: http://localhost:8000"
echo ""
echo "🎉 Projeto Laravel + MySQL criado com sucesso!"
