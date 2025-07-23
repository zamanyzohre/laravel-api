#!/bin/bash

# فقط یک بار key رو تولید کن اگر وجود نداره
if [ ! -f /app/storage/oauth-private.key ]; then
  php artisan key:generate
  php artisan migrate --force
fi

# اجرای اصلی لاراول
php artisan serve --host=0.0.0.0 --port=8000
