FROM babim/alpinebase

ENV auid 1000
ENV agid 1000

RUN set -x \
 && apk add --no-cache ca-certificates curl ffmpeg python \
    # Install youtube-dl
    # https://github.com/rg3/youtube-dl
 && curl -Lo /usr/local/bin/youtube-dl https://yt-dl.org/downloads/latest/youtube-dl \
 && chmod a+rx /usr/local/bin/youtube-dl \
    # Clean-up
 && apk del curl \
    # Create directory to hold downloads.
 && mkdir /downloads \
 && chmod a+rw /downloads \
    # Basic check it works.
 && youtube-dl --version

ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

# create user
RUN adduser -S -D -u $auid -g $agid user

WORKDIR /downloads
VOLUME ["/downloads"]

USER user

ENTRYPOINT ["youtube-dl"]
CMD ["--help"]
