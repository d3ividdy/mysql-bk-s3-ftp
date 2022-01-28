# Mysql Bakup Aws S3 & FTP Server

Imagem para geração do dump com envio para Aws S3 & FTP Server

## Repositorio & Registry

[Github](https://github.com/deividdysousa/mysql-bk-s3-ftp)
[DockerHub](https://hub.docker.com/r/deividdy/mysql-bk-s3-ftp)

## Exemplos

- [Docker Compose](docker-compose.yml)
- [Deployment CronJob K8S](deployment.yml)

- Run CLI

```sh
docker run --name bk \
    -e MYSQL_HOST=localhost \
    -e MYSQL_PORT=3306 \
    -e MYSQL_USER=root \
    -e MYSQL_PASS=root \
    -e MYSQLDUMP_DATABASE=test \
    -e MYSQLDUMP_OPTIONS="--default-character-set=utf8 --single-transaction=TRUE" \
    -e S3_ACCESS_KEY_ID="" \
    -e S3_SECRET_ACCESS_KEY="" \
    -e S3_BUCKET="s3-bucket-aws" \
    -e S3_PREFIX=backup \
    -e S3_REGION="us-east-1" \
    -e FTP_USER=root \
    -e FTP_PASS=root \
    -e FTP_HOST=localhost:30000 \
    -e FTP_PATH=backup \
    -e FTP_OPTIONS="--ftp-ssl" \
    deividdy/mysql-bk-s3-ftp:latest
```

---

## Enviromment

Variaveis de Ambiente necessarias

- MYSQL_HOST: host mysql
- MYSQL_PORT: port mysql
- MYSQL_USER: user mysql
- MYSQL_PASS: password mysql
- MYSQLDUMP_DATABASE: mysql database
- MYSQLDUMP_OPTIONS: mysql custom paramters

- S3_ACCESS_KEY_ID: access key id S3
- S3_SECRET_ACCESS_KEY: access key S3
- S3_BUCKET: bucket s3
- S3_PREFIX: path S3 bucket
- S3_REGION: region S3 bucket
- S3_FILE_NAME: file name in s3

- FTP_USER: user ftp
- FTP_PASS: password ftp
- FTP_HOST: host ftp
- FTP_PATH: path ftp
- FTP_FILE_NAME: file name in ftp
- FTP_OPTIONS: custon ftp arguments [ex: --ftp-ssl]

## Comandos Uteis

- Gerando uma nova versão da Imagem:

```sh
docker tag <IMAGE> deividdy/mysql-bk-s3-ftp:<VERSION>
push deividdy/mysql-bk-s3-ftp:<VERSION>

docker build -t deividdy/mysql-bk-s3-ftp:latest . --no-cache
docker push deividdy/mysql-bk-s3-ftp:latest
```
