# 🐘 Template Laravel + MySQL

Template validado para criação rápida de projetos Laravel com MySQL.

## 🚀 Comando para Cursor

```bash
crie um ambiente de desenvolvimento para o laravel + mysql
```

## 📋 Pré-requisitos

- PHP 8.1+
- Composer
- MySQL 8.0+
- Node.js 18+

## 🛠️ Setup Automático

Execute o script de setup:

```bash
./setup.sh
```

## 📁 Estrutura do Projeto

```
laravel-project/
├── app/
├── config/
├── database/
│   ├── migrations/
│   └── seeders/
├── resources/
│   ├── views/
│   └── js/
├── routes/
├── .env.example
├── composer.json
├── package.json
└── docker-compose.yml
```

## ⚙️ Configurações Incluídas

- ✅ Laravel 10.x
- ✅ MySQL 8.0
- ✅ Autenticação básica
- ✅ Migrations de exemplo
- ✅ Seeders configurados
- ✅ Docker Compose
- ✅ Vite para assets
- ✅ Tailwind CSS
- ✅ Alpine.js

## 🔧 Variáveis de Ambiente

Copie `.env.example` para `.env` e configure:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=laravel_app
DB_USERNAME=root
DB_PASSWORD=
```

## 🐳 Docker

```bash
docker-compose up -d
```

## 📝 Próximos Passos

1. Configure as variáveis de ambiente
2. Execute as migrations: `php artisan migrate`
3. Execute os seeders: `php artisan db:seed`
4. Instale as dependências: `npm install`
5. Compile os assets: `npm run dev`

## 🧪 Testes

```bash
php artisan test
```

## 📚 Documentação

- [Laravel Docs](https://laravel.com/docs)
- [MySQL Docs](https://dev.mysql.com/doc/)
