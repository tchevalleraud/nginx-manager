FROM ubuntu:18.04

ENV NGINX_VERSION=1.21.6
ENV NGINX_PATCH_VERSION=1.20.1
ENV OPENSSL_VERSION=1.1.1n

ENV HTTP_PORT=80
ENV HTTPS_PORT=443
ENV MGMT_PORT=81

RUN apt-get update && apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install gettext-base software-properties-common git unzip wget build-essential libgeoip-dev libpcre3 libpcre3-dev zlibc zlib1g zlib1g-dev sudo nano

WORKDIR /tmp/

RUN wget https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && tar xvzf nginx-${NGINX_VERSION}.tar.gz
RUN wget https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz && tar xzvf openssl-${OPENSSL_VERSION}.tar.gz
RUN git clone http://github.com/vozlt/nginx-module-sts.git
RUN git clone http://github.com/vozlt/nginx-module-stream-sts.git
RUN git clone http://github.com/vozlt/nginx-module-vts.git
RUN git clone http://github.com/yaoweibin/nginx_upstream_check_module.git

WORKDIR /tmp/nginx-${NGINX_VERSION}

RUN patch -p1 < /tmp/nginx_upstream_check_module/check_${NGINX_PATCH_VERSION}+.patch
RUN ./configure --prefix=/usr/share/nginx \
                --sbin-path=/usr/sbin/nginx \
                --modules-path=/usr/lib/nginx/modules \
                --conf-path=/etc/nginx/nginx.conf \
                --pid-path=/run/nginx.pid \
                --lock-path=/var/lock/nginx.lock \
                --user=www-data \
                --group=www-data \
                --with-openssl=/tmp/openssl-${OPENSSL_VERSION} \
                --with-http_geoip_module \
                --with-stream \
                --add-module=/tmp/nginx-module-sts \
                --add-module=/tmp/nginx-module-stream-sts \
                --add-module=/tmp/nginx-module-vts \
                --add-module=/tmp/nginx_upstream_check_module

RUN make
RUN make install

WORKDIR /tmp/

RUN git clone https://github.com/Fleshgrinder/nginx-sysvinit-script.git
WORKDIR /tmp/nginx-sysvinit-script
RUN make

WORKDIR /

RUN rm -Rf /tmp/*
RUN mkdir /var/nginx
RUN mkdir /var/nginx/error
RUN mkdir /var/log/nginx
RUN touch /var/log/nginx/access.log

ADD nginx/error/ /var/nginx/error/
ADD nginx/fastcgi.conf /etc/nginx/fastcgi.conf
ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/proxy.conf /etc/nginx/proxy.conf
RUN chmod +x /etc/init.d/nginx
RUN /usr/sbin/update-rc.d -f nginx defaults

ADD entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE ${HTTP_PORT}
EXPOSE ${HTTPS_PORT}
EXPOSE ${MGMT_PORT}

ENTRYPOINT ["/usr/bin/entrypoint.sh"]