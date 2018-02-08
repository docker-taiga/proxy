#!/bin/sh

INITIAL_SETUP_LOCK=/run/initial_setup.lock
if [ ! -f $INITIAL_SETUP_LOCK ]; then
    touch $INITIAL_SETUP_LOCK
    sed -e 's/$TAIGA_HOSTNAME/'$TAIGA_HOSTNAME'/' \
        -e 's/$TAIGA_BACK_HOST/'$TAIGA_BACK_HOST'/' \
        -e 's/$TAIGA_FRONT_HOST/'$TAIGA_FRONT_HOST'/' \
        -e 's/$EVENTS_HOST/'$EVENTS_HOST'/' \
        -e 's/$CERT_NAME/'$CERT_NAME'/' \
        -e 's/$CERT_KEY/'$CERT_KEY'/' \
        -i /tmp/taiga-conf/nginx.conf
    cp /tmp/taiga-conf/nginx.conf /taiga-conf/
    ln -sf /taiga-conf/nginx.conf /etc/nginx/conf.d/nginx.conf
fi

exec nginx -g 'daemon off;'