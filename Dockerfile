
# alpine:3.6
FROM alpine@sha256:d6bfc3baf615dc9618209a8d607ba2a8103d9c8a405b3bd8741d88b4bef36478

RUN apk add --no-cache \
    php7 \
    php7-ctype \
    php7-curl \
    php7-dom \
    php7-fileinfo \
    php7-gd \
    php7-imagick \
    php7-json \
    php7-mbstring \
    php7-openssl \
    php7-pdo \
    php7-phar \
    php7-tokenizer \
    php7-xml \
    php7-xmlwriter \
    php7-zip \
    unzip \
    wget

ENV COMPOSER_VERSION 1.5.2
ENV COMPOSER_CHECKSUM c0a5519c768ef854913206d45bd360efc2eb4a3e6eb1e1c7d0a4b5e0d3bbb31f
RUN wget -q https://getcomposer.org/download/$COMPOSER_VERSION/composer.phar && \
    echo "$COMPOSER_CHECKSUM  composer.phar" | sha256sum -c - && \
    mv composer.phar /usr/bin/composer && \
    chmod +x /usr/bin/composer

ENV STATAMIC_VERSION 2.8.10
ENV STATAMIC_CHECKSUM be546b067c84b42efd8865f7169050a3cec07d3aabaa1f4c9dfa837bae60182f
RUN wget -q https://outpost.statamic.com/v2/get/$STATAMIC_VERSION -O statamic-$STATAMIC_VERSION.zip && \
    echo "$STATAMIC_CHECKSUM  statamic-$STATAMIC_VERSION.zip" | sha256sum -c - && \
    unzip -q statamic-$STATAMIC_VERSION.zip -d /tmp/ && \
    rm statamic-$STATAMIC_VERSION.zip

WORKDIR /tmp/statamic/
EXPOSE 3000

ENTRYPOINT ["/usr/bin/php"]
CMD ["-d", "memory_limit=512M", "-S", "0.0.0.0:3000", "statamic/server.php"]
