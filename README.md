# Adyen [Magento 2 Plugin](https://docs.adyen.com/plugins/magento-2) integration demo

In this demo, you can spin up a Magento instance and install the Adyen plugin to see how an integration works. It gives your shoppers the option to pay with their preferred payment method in a seamless checkout experience. You can try this demo both online or on your computer.

## Running online with [Gitpod](https://gitpod.io/)

* Open your [Adyen Test Account](https://ca-test.adyen.com/ca/ca/overview/default.shtml) and create a set of [API keys](https://docs.adyen.com/user-management/how-to-get-the-api-key).
* Go to [gitpod account variables](https://gitpod.io/variables).
* Set the `ADYEN_API_KEY`, `ADYEN_CLIENT_KEY` and `ADYEN_MERCHANT_ACCOUNT` variables (Scope: `adyen-examples/*`).
* Click the button below and **wait at least 150s** (for the Magento installation) before the next step!

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/adyen-examples/adyen-magento-plugin)

* Open a new Terminal in the current directory and run `./install.sh` to install and configure the plugin
* Visit your shop on the generated Gitpod subdomain

_NOTE: To allow the Adyen Drop-In and Components to load, you have to add `https://*.gitpod.io` as allowed origin for your chosen set of [API Credentials](https://ca-test.adyen.com/ca/ca/config/api_credentials_new.shtml)_

## Running locally

If you don't want to run this demo online, then follow these steps.

### Requirements

* Docker

### Installation

1. Clone this repo:

```
git clone https://github.com/adyen-examples/adyen-magento-plugin.git
```

2. Navigate to the root directory, set `APP_URL` and port. You can use your preferred port:

```
export APP_URL=127.0.0.1:8080
```

3. Run docker compose to spin up the Magento Docker image. This may take a few minutes depending on your internet and system speed.

```
docker-compose up
```

4. Open a new terminal tab in the current directory and install the Adyen Magento plugin:

```
./install.sh
```

### Usage

1. Visit shop page http://localhost:8080
2. Login to the admin dashboard (http://localhost:8080/admin/) to configure your [API keys](https://docs.adyen.com/user-management/how-to-get-the-api-key). You can find the default login details in the `docker-compose.yml` file.

Remember to include `http://localhost:8080` in the list of Allowed Origins on the Customer Area.

To try out integrations with test card numbers and payment method details, see [Test card numbers](https://docs.adyen.com/development-resources/test-cards/test-card-numbers).

## Contributing

We commit all our new features directly into our GitHub repository. Feel free to request or suggest new features or code changes yourself as well!

Find out more in our [Contributing](https://github.com/adyen-examples/.github/blob/main/CONTRIBUTING.md) guidelines.

## License

MIT license. For more information, see the **LICENSE** file in the root directory.
