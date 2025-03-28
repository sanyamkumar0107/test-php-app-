# Use the official Debian image as base
FROM debian:bullseye-slim

# Set non-interactive mode for apt
ARG DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies to add repository and install PHP
RUN apt-get update && apt-get install -y \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    php-pear \
    && curl -fsSL https://packages.sury.org/php/README.txt | bash -x \
    && apt-get update

# Remove any existing PHP versions (like PHP 7.4)
RUN apt-get remove --purge -y php7.* && apt-get autoremove -y

# Install PHP 8.0 and necessary extensions
RUN apt-get install -y \
    php8.0 \
    php8.0-amqp \
    php8.0-bcmath \
    php8.0-bz2 \
    php8.0-cgi \
    php8.0-cli \
    php8.0-common \
    php8.0-curl \
    php8.0-fpm \
    php8.0-gd \
    php8.0-grpc \
    php8.0-http \
    php8.0-imap \
    php8.0-interbase \
    php8.0-intl \
    php8.0-mbstring \
    php8.0-mcrypt \
    php8.0-mysql \
    php8.0-raphf \
    php8.0-redis \
    php8.0-snmp \
    php8.0-tidy \
    php8.0-uuid \
    php8.0-xml \
    php8.0-xmlrpc \
    php8.0-yaml \
    php8.0-zip \
    && apt-get clean

# Set the timezone (optional)
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime

# Install additional utilities (optional)
RUN apt-get install -y \
    vim \
    git \
    zip \
    unzip \
    && apt-get clean

# Ensure PHP 8.0 is the default version
RUN update-alternatives --set php /usr/bin/php8.0

# Create necessary directories for PHP-FPM
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

# Add /usr/sbin to the PATH environment variable
ENV PATH="/usr/sbin:${PATH}"

# Clean up unnecessary files
RUN rm -rf /var/lib/apt/lists/*

# Expose necessary ports (if required)
EXPOSE 9000

# Command to run PHP-FPM
CMD ["php-fpm8.0", "-F"]
