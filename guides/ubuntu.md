# Настройка сервера Ubuntu 16.04

## Плейсхолдеры

```
{user} - имя пользователя
{pass} - пароль
{host} - хост машины
{name} - полное имя
{email} - электронная почта
{project} - имя папки проекта
```

## Создание private/public пары ключей

### На локальном компьютере:

```bash
ssh-keygen -t rsa -b 4096 -C "{user}"
cat ~/.ssh/{user}.pub | ssh root@{host} 'cat >> .ssh/authorized_keys'
```

## Обновление системы и установка базовых программ

```bash
apt-get update
apt-get upgrade

apt-get install mc htop vim
```

## Добавление пользователя

```bash
adduser {user}
gpasswd -a {user} sudo

su - {user}

mkdir .ssh
chmod 700 .ssh

nano .ssh/authorized_keys
chmod 600 .ssh/authorized_keys

exit

nano /etc/ssh/sshd_config ("PermitRootLogin no", "PasswordAuthentication no")

service ssh restart
```

## Firewall

```bash
sudo ufw allow ssh
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 25/tcp

sudo ufw show added
sudo ufw enable
```

## Дата

```bash
sudo dpkg-reconfigure tzdata

sudo apt-get update
sudo apt-get install ntp
```

## Swap

```bash
sudo fallocate -l 512M /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo sh -c 'echo "/swapfile none swap sw 0 0" >> /etc/fstab'

sudo reboot
```

## LEMP

```bash
sudo apt-get update
sudo apt-get install nginx

sudo apt-get install mysql-server
sudo mysql_install_db
sudo mysql_secure_installation

mysql -u root -p

CREATE USER '{user}'@'localhost' IDENTIFIED BY '{pass}';
GRANT ALL PRIVILEGES ON * . * TO '{user}'@'localhost';
FLUSH PRIVILEGES;

sudo apt-get install php7.0-fpm php7.0-mysql php7.0-mcrypt php7.0-intl php7.0-curl php7.0-cli

sudo nano /etc/php/7.0/fpm/php.ini ("cgi.fix_pathinfo=0")

sudo service php7.0-fpm restart
```

## Git

### Установка

```bash
sudo apt-get update
sudo apt-get install git

git config --global user.name "{name}"
git config --global user.email "{email}"
git config --global core.excludesfile "~/.gitignore"

cat > ~/.gitignore

vendor/*
.idea/*
node_modules/*
bower_components/*
npm-debug.log
*.iml
```

### Конфигурация для проекта

```bash
cd /var/www/{project}/

git init
git config receive.denyCurrentBranch ignore
cat > .git/hooks/post-receive

#!/bin/sh
cd ..
GIT_DIR='.git'
git reset --hard

chmod +x .git/hooks/post-receive
```

### На локальном компьютере (на примере [silex-bicycle](https://github.com/psimonov/silex-bicycle)):

```bash
git clone https://github.com/psimonov/silex-bicycle.git {project}

cd {project}
rm -rf .git

git remote add --track master production ssh://{user}@{project}/var/www/{project}/
git push --set-upstream production master
```

## Shell

```bash
sudo apt-get install zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

## Права

```bash
sudo adduser {user} www-data
sudo chown {user}:www-data -R /var/www

sudo chmod 0755 -R /var/www
sudo chmod g+s -R /var/www
```

### Для Symfony 2

```bash
sudo chmod 0777 -R /var/www/{project}/app/cache
sudo chmod g+s -R /var/www/{project}/app/cache

sudo chmod 0777 -R /var/www/{project}/app/logs 
sudo chmod g+s -R /var/www/{project}/app/logs
```
