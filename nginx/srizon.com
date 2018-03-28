
server {

    server_name srizon.com   www.srizon.com;

    access_log /var/log/nginx/srizon.com.access.log rt_cache;
    error_log /var/log/nginx/srizon.com.error.log;

    root /var/www/srizon.com/public;

    index index.php index.html index.htm;

    include common/php7.conf;

    include common/locations-php7.conf;
}

