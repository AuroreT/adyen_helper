import 'package:flutter/services.dart';

import 'adyen_helper.dart';

class AdyenHelperManager {
  static const MethodChannel _channel = MethodChannel('adyen_helper');

  Future<AdyenEncryptedCardMdl?> encryptCard(
      {required CreditCardMdl card, required String adyenKey}) async {
    try {
      dynamic adyenEncryptedCardFields =
          await _channel.invokeMethod('encryptCreditCard', <String, String>{
        "number": card.number,
        "holderName": card.holderName,
        "expiryMonth": card.expiryMonth,
        "expiryYear": card.expiryYear,
        "cvc": card.cvc,
        "adyenKey": adyenKey
      });

      AdyenEncryptedCardMdl encryptedCard = AdyenEncryptedCardMdl(
          encryptedExpiryMonth:
              adyenEncryptedCardFields["EncryptedExpiryMonth"] ?? '',
          encryptedCardNumber:
              adyenEncryptedCardFields["EncryptedCardNumber"] ?? '',
          encryptedExpiryYear:
              adyenEncryptedCardFields["EncryptedExpiryYear"] ?? '',
          encryptedSecurityCode:
              adyenEncryptedCardFields["EncryptedSecurityCode"] ?? '');

      return encryptedCard;
    } catch (e) {
      return Future.error(e);
    }
  }
}
