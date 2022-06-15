ARG PHP_VERSION

FROM php:${PHP_VERSION:+${PHP_VERSION}-}fpm
ARG COMPOSER_VERSION
ARG NODE_VERSION
ARG NPM_VERSION
ARG YARN_VERSION


ARG USERNAME=developer
ARG USER_UID=1000
ARG USER_GID=1000

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /root

LABEL maintainer="George Barbu"
LABEL version="1.x"
LABEL description="Development environment for the joy and pleasure of web developers"

WORKDIR /usr/local/apache2/htdocs/

# Create system user to run Composer and Other Commands
RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --create-home --shell /bin/bash --uid ${USER_UID} --gid ${USER_GID} ${USERNAME}
USER $user

RUN apt-get update > /dev/null && apt-get install -y \
   libzip-dev \
   git \
   ssh \
   openssh-client \
   unzip \
   libjpeg-dev \
   libxpm-dev \
   libwebp-dev \
   libfreetype6-dev \
   libjpeg62-turbo-dev \
   libmcrypt-dev \
   libpng-dev \
   zlib1g-dev \
   libicu-dev \
   jpegoptim \
   g++ \
   libxrender1 \
   libfontconfig \
   nano \
   cron \
   acl


RUN docker-php-ext-configure intl \
   && docker-php-ext-install intl > /dev/null \
   && docker-php-ext-install zip > /dev/null \
   && docker-php-ext-install bcmath > /dev/null \
   && docker-php-ext-install gd > /dev/null

RUN docker-php-ext-install pdo pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION}

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install nodejs -y

# Install npm
RUN npm install -g npm@${NPM_VERSION}
# Install yarn
RUN npm install -g yarn@${YARN_VERSION}

COPY php.ini /usr/local/etc/php/php.ini

RUN mkdir /root/.ssh
COPY .ssh/id_rsa /root/.ssh/id_rsa
RUN chmod 400 /root/.ssh/id_rsa
RUN ssh-keyscan -t rsa bitbucket.yourcompany.com >>~/.ssh/known_hosts

RUN chmod go-w /root
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/id_rsa

RUN echo "Host bitbucket.yourcompany.com\n\tStrictHostKeyChecking no\n\tPort 7999\n" >> /root/.ssh/config
RUN git config --global url."git@bitbucket.yourcompany.com:7999/".insteadOf "https://bitbucket.yourcompany.com/bitbucket/scm/" && cat /root/.gitconfig
