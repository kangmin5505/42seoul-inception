#! /bin/sh

if [ ! -f "/srv/www/wordpress/adminer.php" ]; then
	mkdir -p /srv/www/wordpress
	curl -s -L -o /srv/www/wordpress/adminer.php \
		https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php
fi

exec php-fpm7 -F