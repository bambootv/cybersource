# CyberSource Integration Guide

Instructions to send request to CyberSource to perform electronic payment.

## Content

1. [Related Documents](#related_documents)
2. [Development Environment](#development_environment)
3. [Function List](#functions_list)
4. [Processing Flow](#processing_flow)
5. [Getting Started](#getting_started)
6. [Data For Test](#data_for_test)
7. [Makefile](#makefile)

## Related Documents

* [Secure_Acceptance_Checkout_API](http://apps.cybersource.com/library/documentation/dev_guides/Secure_Acceptance_Checkout_API/Secure_Acceptance_Checkout_API.pdf)

## Development Environment

* Ruby version 1.9
* Docker version 19.03.1

## Function List

* This repository is improved version of samples ruby repository
    ![cybersource_samples_code](/images/cybersource_samples_code.png)

* For this endpoint:

    ![function_list](/images/function_list.png)

## Processing Flow

* From these data:

    ```yaml
    reference_number=123456789
    transaction_type=sale,create_payment_token
    currency=usd
    amount=100.00
    locale=en
    access_key=e2b0c0d0e0f0g0h0i0j0k0l0m0n0o0p3
    profile_id=0FFEAFFB-8171-4F34-A22D-1CD38A28A384
    transaction_uuid=02815b4f08e56882751a043839b7b481
    signed_date_time=2013-07-11T15:16:54Z
    signed_field_names=access_key,profile_id,transaction_uuid,signed_field_names,unsigned_field_names,signed_date_time,locale,transaction_type,reference_number,amount,currency,payment_method,bill_to_forename,bill_to_surname,bill_to_email,bill_to_phone,bill_to_address_line1,bill_to_address_city,bill_to_address_state,bill_to_address_country,bill_to_address_postal_code
    unsigned_field_names=card_type,card_number,card_expiry_date,card_cvn
    payment_method=card
    bill_to_forename=Joe
    bill_to_surname=Smith
    bill_to_email=joesmith@example.com
    bill_to_address_line1=1 My Apartment
    bill_to_address_city=Mountain View
    bill_to_address_postal_code=94043
    bill_to_address_state=CA
    bill_to_address_country=US
    ```

    back_end create signature with `secret_key`

    ```yaml
    signature=WrXOhTzhBjYMZROwiCug2My3jiZHOqATimcz5EBA07M=
    ```

* Front-end send all above data and card information to CyberSource.

    ```yaml
    card_type=001
    card_cvn=005
    card_number=4111111111111111
    card_expiry_date=12-2022
    ```

* If data is invalid, response will have error code 403.
* Depending on the value of the card, request will redirect to 3D Secure screen or customer response page.

## Getting Started

* Update key

    Get key in the [Business Center](https://ebc2test.cybersource.com/ebc2/app/PaymentConfiguration/SecureAcceptanceSettings)

    ```yaml
    cp config.rb.example config.rb
    ```

* Build and run with docker

    ```yaml
    cd <project_path>
    docker build -t ruby_thin .
    docker run -v `pwd`:/my_app -p 3001:3001 -it ruby_thin /bin/bash
    ```

* On brower
  * <http://localhost:3001/paymentbycard>
    ![form_submit_with_card](/images/form_submit_with_card.png)

  * <http://localhost:3001/paymentbytoken>
    ![form_submit_with_token](/images/form_submit_with_token.png)

## Data For Test

* [Chapter 6 - Test and View Transactions](http://apps.cybersource.com/library/documentation/dev_guides/Secure_Acceptance_Checkout_API/Secure_Acceptance_Checkout_API.pdf) (Page 69)

* [Chapter 6 - Testing Payer Authentication Services](http://apps.cybersource.com/library/documentation/dev_guides/Payer_Authentication_SO_API/Payer_Authentication_SO_API.pdf)  (Page 75)

* [Cardinal](https://cardinaldocs.atlassian.net/wiki/spaces/CCen/pages/400654355/3DS+1.0+Test+Cases)

## Makefile

If your OS is Linux or Mac, let use Makefile

* `make dev`
* `make build`
* `make run`
