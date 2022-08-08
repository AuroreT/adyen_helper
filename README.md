# adyen_helper

Adyen custom card integration for Android and iOS. Provide bridge to encrypt credit card data for [adyen payment endpoint](https://docs.adyen.com/payment-methods/cards/custom-card-integration?tab=android_3#make-a-payment).

|             | Android | iOS   |
|-------------|---------|-------|
| **Support** | SDK 21+ | 11.0+ |

## Usage

```dart
String _adyenKey = "<YOUR_ADYEN_KEY>";
CreditCardMdl _creditCard = CreditCardMdl(
    expiryMonth: "<MM>",
    expiryYear: "<YYYY>",
    holderName: "<HOLDER_NAME>",
    number: "CARD_NUMBER",
    cvc: "<CARD_VERIFICATION_CODE>");

void _handleResult(AdyenEncryptedCardMdl? value) {
  // TODO  
}

AdyenHelperManager()
  .encryptCard(card: _creditCard, adyenKey: _adyenKey)
  .then((value) => _handleResult(value))
  .onError((error, stackTrace) => print(error));  
```