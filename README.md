### Shell script that fixes laravel folder permissions
This script provides a comprehensive solution for fixing Laravel project permissions. Here's how to use it:

Save the script as fix-laravel-permissions.sh
Make it executable:

```bash
chmod +x fix-laravel-permissions.sh
```
Run it with your Laravel project path:

```bash
./fix-laravel-permissions.sh /path/to/your/laravel/project
```
The script:

Sets proper ownership between your user and the web server user
Sets correct permissions for different types of files and directories
Gives special attention to sensitive directories like storage and bootstrap/cache
Protects the .env file
Handles git directory permissions if present
Clears Laravel cache after permission changes

Note: The script assumes your web server runs as www-data. If you're using a different web server user (like nginx or apache), you'll need to modify the WEB_SERVER_USER variable in the script.
