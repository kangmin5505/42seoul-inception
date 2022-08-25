#! /bin/sh
# Modifying configuration file www.conf
sed -i "s/^listen = 127.0.0.1:9000$/listen = 9000/g" /etc/php7/php-fpm.d/www.conf
sed -i "s/;listen.mode\s*=\s*0660/listen.mode = ${PHP_FPM_LISTEN_MODE}/g" /etc/php7/php-fpm.d/www.conf
sed -i "s/;log_level\s*=\s*notice/log_level = notice/g" /etc/php7/php-fpm.d/www.conf #uncommenting line

# Modifying configuration file php.ini
sed -i "s/display_errors\s*=\s*Off/display_errors = ${PHP_DISPLAY_ERRORS}/i" /etc/php7/php.ini
sed -i "s/display_startup_errors\s*=\s*Off/display_startup_errors = ${PHP_DISPLAY_STARTUP_ERRORS}/i" /etc/php7/php.ini
sed -i "s/error_reporting\s*=\s*E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = ${PHP_ERROR_REPORTING}/i" /etc/php7/php.ini
sed -i "s/;*cgi.fix_pathinfo=.*/cgi.fix_pathinfo= ${PHP_CGI_FIX_PATHINFO}/i" /etc/php7/php.ini

if [ ! -f '/srv/www/wordpress/wp-config.php' ]; then
	mkdir -p /srv/www
	wp core download --path=/srv/www/wordpress --allow-root
	wp config create --path=/srv/www/wordpress --dbhost=mariadb \
                 --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" \
				 --allow-root
  	wp core install --path=/srv/www/wordpress --url="$WP_URL" --title="$WP_TITLE" \
                  --admin_name="$WP_ADMIN_NAME" --admin_password="$WP_ADMIN_PASSWORD" \
                  --admin_email="$WP_ADMIN_EMAIL" --allow-root
	wp plugin install redis-cache --activate --path=/srv/www/wordpress --allow-root 
	sed -i "/Add any custom values/a\define( 'WP_REDIS_HOST', 'redis' );" /srv/www/wordpress/wp-config.php
	sed -i "/Add any custom values/a\define( 'WP_REDIS_PORT', ${WP_REDIS_PORT} );" /srv/www/wordpress/wp-config.php
	sed -i "/Add any custom values/a\define( 'WP_REDIS_TIMEOUT', ${WP_REDIS_TIMEOUT} );" /srv/www/wordpress/wp-config.php
	sed -i "/Add any custom values/a\define( 'WP_REDIS_READ_TIMEOUT', ${WP_REDIS_READ_TIMEOUT} );" /srv/www/wordpress/wp-config.php
	sed -i "/Add any custom values/a\define( 'WP_REDIS_DATABASE', ${WP_REDIS_DATABASE} );" /srv/www/wordpress/wp-config.php
	wp redis enable --path=/srv/www/wordpress --allow-root
fi

exec php-fpm7 -F