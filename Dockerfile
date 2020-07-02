FROM fakereto/docker-phpfpm:7.3
MAINTAINER Andres Vejar <andresvejar@neubox.net>

ENV OS_LOCALE="en_US.UTF-8" \
    DEBIAN_FRONTEND=noninteractive
ENV LANG=${OS_LOCALE} \
    LANGUAGE=${OS_LOCALE} \
    LC_ALL=${OS_LOCALE} \
	NGINX_CONF_DIR=/etc/nginx

RUN	\
	BUILD_DEPS='software-properties-common wget gnupg' \
	&& apt-get update \
	&& apt-get install --no-install-recommends -y $BUILD_DEPS \
	# Install supervisor
	&& apt-get install -y supervisor && mkdir -p /var/log/supervisor

	# Cleaning
RUN apt-get clean \
	&& apt-get purge -y --auto-remove --allow-remove-essential $BUILD_DEPS \
	&& rm -rf /var/lib/apt/lists/* \
	# Forward request and error logs to docker log collector
	&& ln -sf /dev/stdout /var/log/supervisor/supervisord.log

COPY ./config/app.conf /etc/supervisor/conf.d/
COPY ./app /var/www/app/

RUN chown www-data:www-data /var/www/app/ -Rf

WORKDIR /var/www/app/
VOLUME /var/www/app/
VOLUME /etc/supervisor/conf.d/

COPY entrypoint.sh /var/www/
ENTRYPOINT ["/var/www/entrypoint.sh"]
