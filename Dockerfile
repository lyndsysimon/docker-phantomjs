FROM alpine:3.6

# install dumb-init
RUN apk update && apk add --no-cache openssl ca-certificates && \
    wget -O /bin/dumb-init http://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 && \
    apk del ca-certificates openssl && \
    chmod +x /bin/dumb-init

ENTRYPOINT ["/bin/dumb-init", "--"]

# install phantomjs
RUN apk update && apk add --no-cache fontconfig curl && \
  mkdir -p /usr/share && \
  cd /usr/share \
  && curl -L https://github.com/Overbryd/docker-phantomjs-alpine/releases/download/2.11/phantomjs-alpine-x86_64.tar.bz2 | tar xj \
  && apk del curl \
  && ln -s /usr/share/phantomjs/phantomjs /usr/bin/phantomjs \
  && phantomjs --version

EXPOSE 9134

CMD ["phantomjs", "--webdriver=9134"]
