```bash
add-apt-repository -y 'ppa:ondrej/php'
add-apt-repository -y 'ppa:ondrej/nginx'
add-apt-repository -y ppa:certbot/certbot
apt-get update
apt-get -y install gcc curl gzip sqlite3 git tar software-properties-common nginx php7.2-fpm php7.2-xml php7.2-bz2  php7.2-zip php7.2-mysql php7.2-intl php7.2-gd php7.2-curl php7.2-soap php7.2-mbstring python-certbot-nginx mysql-server

# todo

#after adding site
#certbot --nginx
```