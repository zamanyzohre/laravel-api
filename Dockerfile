# استفاده از PHP 8.2 با CLI
FROM php:8.2-apache

# نصب ابزارهای لازم
RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    git \
    libzip-dev \
    libpng-dev \
    mariadb-client \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    zip \
    && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl bcmath

# نصب Composer از نسخه رسمی
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# تنظیم مسیر کاری
WORKDIR /app

# کپی تمام فایل‌های پروژه به کانتینر
COPY . .

# نصب وابستگی‌های PHP
RUN composer install --no-dev --optimize-autoloader

# تنظیم دسترسی مناسب
RUN chmod -R 775 storage bootstrap/cache

# اضافه‌کردن فایل entrypoint (دستورهای Artisan)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# باز کردن پورت لاراول
EXPOSE 8000

# اجرای فایل entrypoint
CMD ["/entrypoint.sh"]
