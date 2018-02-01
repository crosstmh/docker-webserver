#base ubuntu image
From ubuntu:16.04

ENV php_conf /etc/php/7.1/fpm/php.ini
ENV nginx_conf /etc/nginx/nginx.conf

MAINTAINER tmh169@163.com

Run apt-get update && apt-get install -y software-properties-common python-software-properties && LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php && \ 
apt-get update && apt-get install -y php7.1 && apt-get install -y php7.1-fpm && \
apt-get install -y libapache2-mod-php7.1 php7.1-cli php7.1-common php7.1-mbstring php7.1-gd php7.1-intl php7.1-xml php7.1-mysql php7.1-mcrypt php7.1-mbstring && \
apt-get install -y php-redis php7.1-opcache php7.1-curl php7.1-json php7.1-zip && apt-get install -y supervisor

Run apt-get update

Run apt-get install -y nginx
Run apt-get install -y vim

RUN rm -v /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.php /var/www/html/index.php
COPY php.ini /etc/php/7.1/fpm/php.ini
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


RUN sed -i -e 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' ${php_conf}
#first php run to create sock file
RUN service php7.1-fpm start
EXPOSE 80 443

CMD service supervisor start
