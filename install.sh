#!/usr/bin/env bash

# Install N98-Magerun
docker exec magento2-container wget -q https://files.magerun.net/n98-magerun2.phar
docker exec magento2-container chmod +x ./n98-magerun2.phar

# Enable developer mode
docker exec magento2-container bin/magento deploy:mode:set developer

# Install latest release 
docker exec magento2-container composer require adyen/module-payment

# Enable module
docker exec magento2-container bin/magento module:enable Adyen_Payment


# Setup upgrade
docker exec magento2-container bin/magento setup:upgrade

# Generate code
docker exec magento2-container bin/magento setup:di:compile

# Clear cache
docker exec magento2-container bin/magento cache:flush

# Install Express Checkout
docker exec magento2-container composer require adyen/adyen-magento2-expresscheckout
docker exec magento2-container bin/magento module:enable Adyen_ExpressCheckout

# Setup upgrade
docker exec magento2-container bin/magento setup:upgrade

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

# Configure Express checkout module
docker exec magento2-container bin/magento config:set payment/adyen_hpp/show_google_pay_on "1,2,3"
docker exec magento2-container bin/magento config:set payment/adyen_hpp/show_apple_pay_on "1,2,3"

# Clear cache
docker exec magento2-container bin/magento cache:flush

# Crontab
docker exec magento2-container crontab -r
docker exec magento2-container bin/magento cron:install

# Setup permissions
docker exec magento2-container find var generated vendor pub/static pub/media app/etc /var/www/sample-data -type f -exec chmod g+w {} +
docker exec magento2-container find var generated vendor pub/static pub/media app/etc /var/www/sample-data -type d -exec chmod g+ws {} +
docker exec magento2-container chown -R www-data:www-data . /var/www/sample-data
docker exec magento2-container chmod u+x bin/magento

# Clear cache again
docker exec magento2-container bin/magento cache:flush
