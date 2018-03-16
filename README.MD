Readme.md

# Окружение php-разработчика

Окружение представляет из себя один толстый докер контейнер с нужной версией php и nginx, настроенный docker-compose и пачку скриптов на все случаи жизни (почти).

Скрипты позволят быстро развернуть нужный проект, создать, поднять и опустить контейнер, войти в его шелл, запустить phpunit.

# Требования
Для работы необходим только шелл (/bin/sh), gnutils, tput и установленный docker. 

Про установку docker можно почитать тут: https://docs.docker.com/install/

# Xdebug
Из коробки доступен Xdebug, remote_port установлен на 9001. О настройке для PhpStorm можно почитать тут: https://www.jetbrains.com/help/phpstorm/configuring-xdebug.html

# Скрипты
## INIT.SH
Удаляет api/src, если существует, и клонирует указанный репозиторий.

Пример:
```sh
$ ./init.sh git@bitbucket.org:devjs_spb/takelook-api.git
```
## BUILD.SH
Билдит все имиджи из текущих сервисов без учета кэша.

## UP.SH
Поднимает все сервисы и подписывается на логи контейнеров.

Каждый раз когда поднимается контейнер api производится установка пакетов (composer install) и заново создается база данных (sqlite) с миграциями и сидами.

## DOWN.SH
Завершает все сервисы.

## EXEC.SH
Запускается /bin/sh в контейнере api от юзера www.

## PHPUNIT.SH
Тесты

## ЧаВО
**В:** При запуске любого скрипта
```sh
The file “./script_name” is not executable by this user
```
**О:**
```sh
$ chmod +x script_name
```

**В:** При запуске build.sh скрипт падает с такой ошибкой
```sh
IOError: Can not access file in context: ../api/src/public/storage
Failed to execute script docker-compose
```
**О:** 
```sh
$ rm -f ../api/src/public/storage
```
