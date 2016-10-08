FROM mhart/alpine-node:0.10
MAINTAINER Daniel Barth <barthinho@freemail4.net>
RUN apk add --no-cache --update --virtual .build-deps make gcc g++ python linux-headers udev \
 && adduser -D sinopia && mkdir -p /opt/sinopia/storage \
 && cd /opt/sinopia \
 && npm install js-yaml sinopia \
 && apk del .build-deps \
 && rm -rf /usr/include \
  /usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp \
  /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html
ADD /config.yaml /tmp/config.yaml
ADD /start.sh /opt/sinopia/start.sh
RUN chown -R sinopia:sinopia /opt/sinopia
WORKDIR /opt/sinopia
USER sinopia
CMD ["/opt/sinopia/start.sh"]
EXPOSE 4873
VOLUME /opt/sinopia