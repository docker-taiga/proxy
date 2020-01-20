#!/bin/sh

update_configs() {
    [ "$ENABLE_SSL" = 'yes' ] && CONFIG_FILE=nginx_ssl.conf || CONFIG_FILE=nginx.conf

    sed -e 's/$TAIGA_HOST/'$TAIGA_HOST'/' \
        -e 's/$TAIGA_BACK_HOST/'$TAIGA_BACK_HOST'/' \
        -e 's/$TAIGA_FRONT_HOST/'$TAIGA_FRONT_HOST'/' \
        -e 's/$EVENTS_HOST/'$EVENTS_HOST'/' \
        -e 's/$CERT_NAME/'$CERT_NAME'/' \
        -e 's/$CERT_KEY/'$CERT_KEY'/' \
        /tmp/taiga-conf/$CONFIG_FILE > /taiga-conf/nginx.conf

    ln -sf /taiga-conf/nginx.conf /etc/nginx/conf.d/nginx.conf
    cp /tmp/taiga-conf/proxy_params /taiga-conf/proxy_params
    ln -sf /taiga-conf/proxy_params /etc/nginx/proxy_params
}

update_configs

exec nginx -g 'daemon off;'
