FROM certbot/certbot:v0.30.2
RUN apk add --no-cache --virtual .plugin-deps git \
 && git clone https://github.com/certbot/certbot /opt/certbot/everything \
 && cd /opt/certbot/everything \
 && git reset --hard v0.30.2 \
 && cd certbot-dns-dnsimple \
 && python setup.py install \
 && apk del .plugin-deps
