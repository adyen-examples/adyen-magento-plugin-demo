#!/usr/bin/env bash

# Install N98-Magerun
docker exec magento2-container wget -q https://files.magerun.net/n98-magerun2.phar
docker exec magento2-container chmod +x ./n98-magerun2.phar

# Enable developer mode
docker exec magento2-container bin/magento deploy:mode:set developer

# Install latest release 
docker exec magento2-container composer require adyen/module-payment:"${MAGENTO_PLUGIN_VERSION}"

# Enable module
docker exec magento2-container bin/magento module:enable Adyen_Payment

# Setup upgrade
docker exec magento2-container bin/magento setup:upgrade

# Generate code
docker exec magento2-container bin/magento setup:di:compile

# Clear cache
docker exec magento2-container bin/magento cache:flush

# Configure the plugin
docker exec magento2-container bin/magento config:set payment/adyen_abstract/demo_mode 1
docker exec magento2-container bin/magento config:set payment/adyen_hpp/active 1
docker exec magento2-container bin/magento config:set payment/adyen_cc/active 1
docker exec magento2-container bin/magento config:set payment/adyen_oneclick/active 1
docker exec magento2-container bin/magento config:set payment/adyen_abstract/merchant_account "${ADYEN_MERCHANT_ACCOUNT}"
docker exec magento2-container ./n98-magerun2.phar config:store:set --encrypt payment/adyen_abstract/api_key_test "${ADYEN_API_KEY}" > /dev/null
docker exec magento2-container bin/magento config:set payment/adyen_abstract/client_key_test "${ADYEN_CLIENT_KEY}"

# Crontab
docker exec magento2-container crontab -r
docker exec magento2-container bin/magento cron:install

# Setup permissions
docker exec magento2-container find var generated vendor pub/static pub/media app/etc /var/www/sample-data -type f -exec chmod g+w {} +
docker exec magento2-container find var generated vendor pub/static pub/media app/etc /var/www/sample-data -type d -exec chmod g+ws {} +
docker exec magento2-container chown -R www-data:www-data . /var/www/sample-data
docker exec magento2-container chmod u+x bin/magento

# Clear cache
docker exec magento2-container bin/magento cache:flush

a2enmod headers

docker cp ./apache2.conf magento2-container:../../../etc/apache2/apache2.conf
docker cp .htaccess magento2-container:pub/.htaccess

docker exec -it magento2-container /bin/bash

chmod -R 777 vendor/adyen
chmod -R 777 var/cache

service apache2 reload

exit
while true 
do echo “hello“
sleep 1200 
done
