# CyberSource Integration Guide

Instructions to send request to CyberSource to perform electronic payment.

## Content

1. [Related Documents](#related_documents)
2. [Development Environment](#development_environment)
3. [Function List](#functions_list)
4. [Getting Started](#getting_started)
5. [Data For Test](#data_for_test)
6. [Note](#note)

## Related Documents
* [Secure_Acceptance_Checkout_API](http://apps.cybersource.com/library/documentation/dev_guides/Secure_Acceptance_Checkout_API/Secure_Acceptance_Checkout_API.pdf)

## Development Environment
* Ruby version 1.9
* Docker version 19.03.1

## Function List
* This repository is improved version of samples ruby repository
    ![](/images/cybersource_samples_code.png)

* For this endpoint:

    ![](/images/function_list.png)

## Getting Started
* Update key
    Get key in the [Business Center](https://ebc2test.cybersource.com/ebc2/app/PaymentConfiguration/SecureAcceptanceSettings)
    ```
    cp config.rb.example config.rb
    ```

* Build and run with docker
    ```
    cd ~/intergration_cybersource_ruby
    docker build -t ruby_thin .
    docker run -v ~/intergration_cybersource_ruby:/my_app -p 3001:3001 -it ruby_thin /bin/bash
    ```

* On brower
    - http://localhost:3001/paymentbycard
    ![](/images/form_submit_with_card.png)

    - http://localhost:3001/paymentbytoken
    ![](/images/form_submit_with_token.png)


## Data For Test

+ [Chapter 6 - Test and View Transactions](http://apps.cybersource.com/library/documentation/dev_guides/Secure_Acceptance_Checkout_API/Secure_Acceptance_Checkout_API.pdf) (Page 69)

+ [Chapter 6 - Testing Payer Authentication Services](http://apps.cybersource.com/library/documentation/dev_guides/Payer_Authentication_SO_API/Payer_Authentication_SO_API.pdf)  (Page 75)

+ [Cardinal](https://cardinaldocs.atlassian.net/wiki/spaces/CCen/pages/400654355/3DS+1.0+Test+Cases)

## Note
* Depending on the value of the card, request will redirect to 3D Secure screen or customer response page
