FROM nginx:stable-alpine
LABEL maintainer="Evgeny Soynov <saboteur@saboteur.me>"

ENV HUGO_VERSION 0.41
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

COPY ./ /site

RUN set -x && \
  cd /tmp && \
  #apk add --update wget ca-certificates && \
  busybox wget https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} && \
  tar xzf ${HUGO_BINARY} && \
  rm -r ${HUGO_BINARY} && \
  rm /var/cache/apk/* && \
  ./hugo --source /site --destination /usr/share/nginx/html && \
  rm -rf ./* && \
  rm -rf /site

EXPOSE 80