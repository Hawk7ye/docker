#!/bin/bash
# Setze Standardwerte, falls die Umgebungsvariablen nicht definiert sind
UPLOAD_MAX_FILESIZE=${UPLOAD_MAX_FILESIZE:-2M}
POST_MAX_SIZE=${POST_MAX_SIZE:-8M}

# Ersetzen von upload_max_filesize und post_max_size in php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = $UPLOAD_MAX_FILESIZE/" /etc/php/8.3/apache2/php.ini
sed -i "s/post_max_size = .*/post_max_size = $POST_MAX_SIZE/" /etc/php/8.3/apache2/php.ini

# Hide Apache Version and OS Information
echo $'\nServerTokens Prod\nServerSignature Off' >> /etc/httpd/conf/httpd.conf

# Starte Apache im Vordergrund
exec /usr/sbin/apache2ctl -D FOREGROUND
