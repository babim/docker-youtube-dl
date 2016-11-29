FROM babim/alpinebase

RUN set -x \
 && apk add --no-cache ca-certificates curl ffmpeg python \
    # Install youtube-dl
    # https://github.com/rg3/youtube-dl
 && curl -Lo /usr/local/bin/youtube-dl https://yt-dl.org/downloads/latest/youtube-dl \
 && chmod a+rx /usr/local/bin/youtube-dl \
    # Clean-up
 && apk del curl \
    # Create directory to hold downloads.
 && mkdir /download \
 && chmod a+rw /download \
    # Basic check it works.
 && youtube-dl --version

ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

WORKDIR /download

VOLUME ["/download"]

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
