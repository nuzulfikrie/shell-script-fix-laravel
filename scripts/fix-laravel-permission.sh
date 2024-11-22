#!/bin/bash

# Check if the path argument is provided
if [ -z "$1" ]; then
    echo "Please provide the Laravel project path"
    echo "Usage: $0 /path/to/laravel/project"
    exit 1
fi

# Store the project path
PROJECT_PATH="$1"

# Check if the path exists
if [ ! -d "$PROJECT_PATH" ]; then
    echo "Error: Directory does not exist"
    exit 1
fi

# Get the current user and web server user (usually www-data)
CURRENT_USER=$(whoami)
WEB_SERVER_USER="www-data"  # Change this if your web server runs as a different user

echo "Fixing permissions for Laravel project at: $PROJECT_PATH"

# Set directory ownership
sudo chown -R $CURRENT_USER:$WEB_SERVER_USER "$PROJECT_PATH"

# Set base directory permissions
find "$PROJECT_PATH" -type d -exec chmod 755 {} \;
find "$PROJECT_PATH" -type f -exec chmod 644 {} \;

# Set storage and bootstrap/cache directory permissions
chmod -R 775 "$PROJECT_PATH/storage"
chmod -R 775 "$PROJECT_PATH/bootstrap/cache"

# Set storage directory special permissions
find "$PROJECT_PATH/storage" -type d -exec chmod 775 {} \;
find "$PROJECT_PATH/storage" -type f -exec chmod 664 {} \;

# Ensure .env file is protected
if [ -f "$PROJECT_PATH/.env" ]; then
    chmod 640 "$PROJECT_PATH/.env"
fi

# Set proper git permissions if .git exists
if [ -d "$PROJECT_PATH/.git" ]; then
    chmod -R 755 "$PROJECT_PATH/.git"
fi

# Clear Laravel cache
if [ -f "$PROJECT_PATH/artisan" ]; then
    php "$PROJECT_PATH/artisan" cache:clear
    php "$PROJECT_PATH/artisan" config:clear
    php "$PROJECT_PATH/artisan" route:clear
    php "$PROJECT_PATH/artisan" view:clear
fi

echo "Permissions have been fixed successfully!"
echo "Directory ownership: $CURRENT_USER:$WEB_SERVER_USER"
echo "Standard directory permissions: 755"
echo "Standard file permissions: 644"
echo "Storage/cache directory permissions: 775"
echo "Storage files permissions: 664"
