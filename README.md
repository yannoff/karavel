# laradoc

An alternative docker stack to [laravel-sail](https://github.com/laravel/sail).

The stack provides the following services:

- [php-fpm](https://github.com/docker-library/php)
- [postgresql](https://github.com/docker-library/postgres) / [mysql](https://github.com/docker-library/mysql/)
- [node api](https://github.com/yannoff/docker-node-api)
- [redis](https://github.com/docker-library/redis)
- [mailcatcher](https://github.com/schickling/dockerfiles/tree/master/mailcatcher)

## Pre-requisites

- Linux or any POSIX equivalent
- docker & docker-compose
- curl <sup>(1)</sup>
- tar <sup>(1)</sup>

_**<sup>(1)</sup>**: Required by the remote install script._

## Usage

### 1. Create laravel skeleton

**Option A:** with composer & php installed locally

```bash
composer create-project laravel/laravel acme
```

**Alternative:** without composer and/or php installed

```bash
docker run --rm -it -u $UID:$UID -w /src -v $PWD:/src yannoff/php-fpm:8.0 composer create-project laravel/laravel acme
```

### 2. Install laradoc stack

Call the remote install script on-the-fly, from the project's top-level dir:

```bash
cd acme
curl -L https://github.com/yannoff/laradoc/releases/latest/download/install.sh | bash
```

> :bulb: *The install script will use the `DB_CONNECTION` env var to determine which db driver config must be used.*

### 3. Customize the .env file

#### Environment variables

_The following environment variables **must be set** to the following values for the stack to run properly:_

Name|Value
---|---
`DB_HOST`|dbserver
`REDIS_HOST`|redis
`MAILER_HOST`|mailer


_Addtionally, the following environment variables may be added/modified in the project's `.env` file for a more fine-tuned stack._

**Main variables**

Name|Description|Fallback value
---|---|---
`DB_DATABASE`|The project's database name|-|
`DB_PASSWORD`|The DB connection password|-|
`DB_USERNAME`|The DB connection username|-|
`HTTP_PORT`|The HTTP port exposed by the web application|8088|
`PHP_VERSION`|PHP Version to use for the `fpm` container|8.0
`WORKDIR`| Working directory for the `fpm` & `node` containers|/src
`TZ`|The application timezone|Europe/Paris|

**MySQL specific variables**

Name|Description|Fallback value
---|---|---
`MYSQL_PORT`|The port exposed by the MySQL server on the host machine|3306|
`MYSQL_VERSION`|MySQL server version|8.0|


**PostgreSQL specific variables**

Name|Description|Fallback value
---|---|---
`PG_PORT`|The port exposed by the PostgreSQL server on the host machine|5432|
`PG_VERSION`|The PostgreSQL server version|9.6

### 4. Start the stack

```bash
docker-compose up -d
```

## About the name

Laradoc is a nod to the [Kaamelott](https://en.wikipedia.org/wiki/Kaamelott) french popular soap opera's famous character [Karadoc](https://en.wikipedia.org/wiki/Caradoc). :smiley_cat:

## License

Licensed under the [MIT License](LICENSE).
