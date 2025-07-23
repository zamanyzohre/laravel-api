#!/bin/bash

# اطمینان از وجود APP_KEY
if [ ! -f /app/storage/app.key ]; then
  echo "🔐 Generating app key and running migrations..."
  php artisan key:generate
  php artisan migrate --force
fi

# لینک دادن storage/public به public/storage (برای نمایش فایل‌های آپلودی)
echo "🔗 Running storage:link..."
php artisan storage:link

# کش کردن تنظیمات
php artisan config:cache
php artisan route:cache
php artisan view:cache

# اجرای Laravel
echo "🚀 Starting Laravel server..."
php artisan serve --host=0.0.0.0 --port=8000
