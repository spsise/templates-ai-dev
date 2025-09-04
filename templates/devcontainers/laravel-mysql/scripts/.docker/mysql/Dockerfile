FROM mysql:5.7

RUN usermod -u 1000 mysql

# Configuração personalizada para usar porta 3308
RUN echo "[mysqld]" > /etc/mysql/conf.d/custom.cnf && \
    echo "port = 3308" >> /etc/mysql/conf.d/custom.cnf
