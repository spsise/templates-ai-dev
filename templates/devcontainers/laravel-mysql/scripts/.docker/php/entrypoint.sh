#!/bin/sh

# Aguardar um pouco para garantir que os serviços dependentes estejam prontos
sleep 5

# Iniciar PHP-FPM em background
php-fpm -D

# Manter o container rodando
exec "$@"
