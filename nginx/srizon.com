server {
    listen 80;
    #load balancer forwarded https
    #if ($http_x_forwarded_proto != 'https') {
    #    return 301 https://$host$request_uri;
    #}
    root /var/www/srizon.com/public;
    index index.php index.html index.htm;
    server_name srizon.com   www.srizon.com;
    charset   utf-8;
    client_max_body_size 120M;
    gzip on;
    gzip_vary on;
    gzip_disable "msie6";
    gzip_comp_level 6;
    gzip_min_length 1100;
    gzip_buffers 16 8k;
    gzip_proxied any;
    gzip_types
        text/plain
        text/css
        text/js
        text/xml
        text/javascript
        application/javascript
        application/x-javascript
        application/json
        application/xml
        application/xml+rss;
    #static single page app on /app directory
    #location /app {
    #    try_files $uri $uri/ /app/index.html?$args;
    #}
    location / {
        try_files $uri $uri/ /index.php?$args;
    }
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.2-fpm.sock;
    }
    location ~* \.(?:jpg|jpeg|gif|png|ico|cur|gz|svg|svgz|mp4|ogg|ogv|webm|htc|svg|woff|woff2|ttf)\$ {
        expires 1M;
        access_log off;
        add_header Cache-Control "public";
    }
    location ~* \.(?:css|js)\$ {
        expires 7d;
        access_log off;
        add_header Cache-Control "public";
    }
    location ~ /\.ht {
        deny  all;
    }
}
