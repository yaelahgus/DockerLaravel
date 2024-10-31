# Use the official PHP image, and ensure it's compatible with Apple Silicon
FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www/html

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    locales \
    zip \
    unzip \
    jpegoptim optipng pngquant gifsicle \
    vim git curl \
    pkg-config

# Install PHP extensions, including zip
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install pdo_mysql exif pcntl bcmath gd zip

# Install Node.js and npm (for Vite)
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Install Composer globally
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy existing application files
COPY . /var/www/html

# Install composer dependencies
RUN composer install

# Ensure permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expose port 8000 and set the entrypoint to run Laravel's built-in server
EXPOSE 8000
CMD php artisan serve --host=0.0.0.0 --port=8000
