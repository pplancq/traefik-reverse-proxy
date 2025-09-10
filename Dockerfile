FROM traefik:v3.5.2

## Installation des packages persistants
RUN apk add --no-cache nss-tools

## Copy du certificat d'autorité si présent
COPY rootCert /root/.local/share/mkcert/

## Ajout de l'utlisation devtls pour évité tous problème lié aux droits
ARG USER_ID=1000
ARG GROUP_ID=1000
ENV USER_ID=$USER_ID
ENV GROUP_ID=$GROUP_ID
RUN set -eux; \
        addgroup -g $USER_ID devtls; \
        adduser -u $GROUP_ID -G devtls -s /bin/sh -D devtls

## Installation de Mkcert et génération des certificats SSL
ARG MKCERT_VERSION=1.4.4
RUN set -eux; \
        wget -O /usr/local/bin/mkcert https://github.com/FiloSottile/mkcert/releases/download/v$MKCERT_VERSION/mkcert-v$MKCERT_VERSION-linux-amd64; \
        chmod +x /usr/local/bin/mkcert; \
        mkdir -p /certs; \
        mkcert --cert-file /certs/cert.pem --key-file /certs/key.pem localhost 127.0.0.1 ::1; \
        chown devtls:devtls /certs -R

COPY docker/rootCert.sh /usr/local/bin/rootCert
RUN chmod +x /usr/local/bin/rootCert
ENTRYPOINT  ["rootCert"]

CMD ["traefik"]
