server {
    server_name accounts.srizon.com;
    location / {
        proxy_pass         http://127.0.0.1:8080/;
        proxy_set_header   Host             $host;
        proxy_set_header   X-Real-IP        $remote_addr;
        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
        proxy_set_header   X-Forwarded-Proto  https;
        client_max_body_size       10m;
        client_body_buffer_size    128k;

        proxy_connect_timeout      90;
        proxy_send_timeout         90;
        proxy_read_timeout         90;

        proxy_buffer_size          4k;
        proxy_buffers              4 32k;
        proxy_busy_buffers_size    64k;
        proxy_temp_file_write_size 64k;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/accounts.srizon.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/accounts.srizon.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = accounts.srizon.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name accounts.srizon.com;
    return 404; # managed by Certbot


}