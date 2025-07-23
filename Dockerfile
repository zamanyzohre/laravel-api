FROM php:8.2-cli

# نصب اکستنشن‌های موردنیاز
RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    git \
    libzip-dev \
    zip \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring zip

# نصب Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# کپی پروژه
WORKDIR /app
COPY . .

# نصب وابستگی‌ها
RUN composer install --optimize-autoloader --no-dev

# پرمیشن
RUN chmod -R 775 storage bootstrap/cache

# پورت
EXPOSE 8000

# اجرای Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]

