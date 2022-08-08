class AdyenEncryptedCardMdl {
  late String encryptedCardNumber;
  late String encryptedExpiryMonth;
  late String encryptedExpiryYear;
  late String encryptedSecurityCode;

  AdyenEncryptedCardMdl(
      {required this.encryptedCardNumber,
      required this.encryptedExpiryMonth,
      required this.encryptedExpiryYear,
      required this.encryptedSecurityCode});

  AdyenEncryptedCardMdl.fromJson(Map<String, dynamic> json) {
    encryptedCardNumber = json['encryptedCardNumber'];
    encryptedExpiryMonth = json['encryptedExpiryMonth'];
    encryptedExpiryYear = json['encryptedExpiryYear'];
    encryptedSecurityCode = json['encryptedSecurityCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['encryptedCardNumber'] = encryptedCardNumber;
    data['encryptedExpiryMonth'] = encryptedExpiryMonth;
    data['encryptedExpiryYear'] = encryptedExpiryYear;
    data['encryptedSecurityCode'] = encryptedSecurityCode;
    return data;
  }
}
