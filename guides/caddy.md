# Настройка Caddy

## Установка сервера

```bash
sudo curl https://getcaddy.com | bash

curl -S https://github.com/mholt/caddy/blob/master/dist/init/linux-systemd/caddy.service
sudo mv caddy.service /etc/systemd/system/
```

## Создание директорий, установка и проверка прав

```bash
sudo mkdir /etc/caddy
sudo chown -R root:www-data /etc/caddy
sudo mkdir /etc/ssl/caddy
sudo chown -R www-data:root /etc/ssl/caddy
sudo chmod 0770 /etc/ssl/caddy

sudo mkdir -p /var/www

sudo adduser {user} www-data
sudo chown {user}:www-data -R /var/www

sudo chmod 0755 -R /var/www
sudo chmod g+s -R /var/www

sudo -u www-data -g www-data -s \
  ls -hlAS /var/www
```

## Настройка и запуск сервера

```bash
curl -S https://raw.githubusercontent.com/psimonov/tricks-and-tips/master/settings/Caddyfile
sudo mv Caddyfile /etc/caddy

sudo systemctl daemon-reload

sudo systemctl start caddy.service
sudo systemctl enable caddy.service
```
