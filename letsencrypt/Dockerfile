FROM alpine:edge

RUN apk add --update \
        bash \
        certbot \
    && rm -rf /var/cache/apk/*

EXPOSE 80
VOLUME /etc/letsencrypt

ENV VIRTUAL_HOST="*/.well-known/acme-challenge/*"
ENV VIRTUAL_HOST_WEIGHT="999"
ENV PATH="/opt/letsencrypt/bin:$PATH"

COPY . /opt/letsencrypt/

CMD ["update-certs.sh"]
