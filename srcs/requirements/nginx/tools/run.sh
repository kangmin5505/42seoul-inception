#! bin/sh

sed -i 's|ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;|ssl_protocols TLSv1.2 TLSv1.3;|g' /etc/nginx/nginx.conf
sed -i "s|{SERVER_NAME}|$SERVER_NAME|g" /etc/nginx/http.d/default.conf

exec nginx -g "daemon off;"