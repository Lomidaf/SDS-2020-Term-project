#!/bin/bash
cd ~
# Install deps
sudo apt update
sudo apt install apache2 libapache2-mod-php7.4 -y
sudo apt install php7.4-gd php7.4-mysql php7.4-curl php7.4-mbstring php7.4-intl -y
sudo apt install php7.4-gmp php7.4-bcmath php-imagick php7.4-xml php7.4-zip -y

# Download nextcloud
wget https://download.nextcloud.com/server/releases/nextcloud-22.2.0.tar.bz2
tar -xjvf nextcloud-22.2.0.tar.bz2
sudo cp -r nextcloud /var/www
sudo rm -r nextcloud

# Apache2 config
sudo touch /etc/apache2/sites-available/nextcloud.conf
sudo chmod 777 /etc/apache2/sites-available/nextcloud.conf
sudo cat << EOF > /etc/apache2/sites-available/nextcloud.conf
Alias /nextcloud "/var/www/nextcloud/"
<Directory /var/www/nextcloud/>
Require all granted
AllowOverride All
Options FollowSymLinks MultiViews

<IfModule mod_dav.c>
    Dav off
</IfModule>
</Directory>
EOF
sudo chmod 644 /etc/apache2/sites-available/nextcloud.conf

# Make config affect
sudo a2ensite nextcloud.conf
sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod env
sudo a2enmod dir
sudo a2enmod mime
sudo service apache2 restart

# S3 config
sudo touch /var/www/nextcloud/config/storage.config.php
sudo chmod 777 /var/www/nextcloud/config/storage.config.php
cat <<- EOF > /var/www/nextcloud/config/storage.config.php
<?php
\$CONFIG = array (
    'objectstore' => [
            'class' => '\\\\OC\\\\Files\\\\ObjectStore\\\\S3',
            'arguments' => [
                    'bucket' => '${bucket_name}',
                    'autocreate' => false,
                    'region' => '${region}',
                    'key'    => '${iam_key}',
                    'secret' => '${iam_secret}',
                    'use_ssl' => true
            ],
    ],
);
EOF

# Cml for install wizard and whitelist domain
sudo chown -R www-data:www-data /var/www/nextcloud/ 
cd /var/www/nextcloud/

sudo -u www-data php occ maintenance:install \
--database "mysql" --database-name "${database_name}" \
--database-user "${database_user}" --database-pass "${database_pass}" \
--database-host "${database_host}" \
--admin-user "${admin_user}" --admin-pass "${admin_pass}"

sudo -u www-data php occ config:system:set trusted_domains 1 \
--value="${app_host}"

cd ~



