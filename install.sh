#!/usr/bin/env bash

# TODO: automate this install (e.g create a custom image to trigger it on compose up)

#  - name: Install N98-Magerun
docker exec magento2-container wget -q https://files.magerun.net/n98-magerun2.phar
docker exec magento2-container chmod +x ./n98-magerun2.phar

# Enable developer mode
docker exec magento2-container bin/magento deploy:mode:set developer

# - name: Install latest release 
docker exec magento2-container composer require adyen/module-payment

# - name: Enable module
docker exec magento2-container bin/magento module:enable Adyen_Payment

# - name: Setup upgrade
docker exec magento2-container bin/magento setup:upgrade

# - name: Generate code
docker exec magento2-container bin/magento setup:di:compile

# - name: Clear cache
docker exec magento2-container bin/magento cache:flush

# - name: Configure the plugin
docker exec magento2-container bin/magento config:set payment/adyen_abstract/demo_mode 1
docker exec magento2-container bin/magento config:set payment/adyen_hpp/active 1
docker exec magento2-container bin/magento config:set payment/adyen_cc/active 1
docker exec magento2-container bin/magento config:set payment/adyen_oneclick/active 1
docker exec magento2-container bin/magento config:set payment/adyen_abstract/merchant_account "${ADYEN_MERCHANT}"
docker exec magento2-container ./n98-magerun2.phar config:store:set --encrypt payment/adyen_abstract/api_key_test "${ADYEN_API_KEY}" > /dev/null
docker exec magento2-container bin/magento config:set payment/adyen_abstract/client_key_test "${ADYEN_CLIENT_KEY}"

# - name: Clear cache
docker exec magento2-container bin/magento cache:flush

# Setup permissions
docker exec magento2-container find var generated vendor pub/static pub/media app/etc /var/www/sample-data -type f -exec chmod g+w {} +
docker exec magento2-container find var generated vendor pub/static pub/media app/etc /var/www/sample-data -type d -exec chmod g+ws {} +
docker exec magento2-container chown -R www-data:www-data . /var/www/sample-data
docker exec magento2-container chmod u+x bin/magento