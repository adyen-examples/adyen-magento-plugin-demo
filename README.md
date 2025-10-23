# Adyen [Magento 2 Plugin](https://docs.adyen.com/plugins/magento-2) integration demo

In this demo, you can spin up a Magento instance and install the [Adyen Payment plugin](https://marketplace.magento.com/adyen-module-payment.html) to see how it works.

## Setup

If you don't want to run this demo online, then follow these steps.

### Requirements

* Docker

### Installation

1. Clone this repo:

```
git clone https://github.com/adyen-examples/adyen-magento-plugin-demo.git
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
2. Login to the admin dashboard (http://localhost:8080/admin/) to configure your [API keys](https://docs.adyen.com/user-management/how-to-get-the-api-key). 
Remember to include `http://localhost:8080` in the list of Allowed Origins on the Customer Area.

To try out integrations with test card numbers and payment method details, see [Test card numbers](https://docs.adyen.com/development-resources/test-cards/test-card-numbers).

## Contributing

We commit all our new features directly into our GitHub repository. Feel free to request or suggest new features or code changes yourself as well!

Find out more in our [Contributing](https://github.com/adyen-examples/.github/blob/main/CONTRIBUTING.md) guidelines.

## License

MIT license. For more information, see the **LICENSE** file in the root directory.
