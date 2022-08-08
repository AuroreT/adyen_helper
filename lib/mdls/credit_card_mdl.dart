class CreditCardMdl {
  late String expiryMonth;
  late String expiryYear;
  late String holderName;
  late String number;
  late String cvc;

  CreditCardMdl({
    required this.expiryMonth,
    required this.expiryYear,
    required this.holderName,
    required this.number,
    required this.cvc,
  });

  CreditCardMdl.fromJson(Map<String, dynamic> json) {
    expiryMonth = json['expiryMonth'];
    expiryYear = json['expiryYear'];
    holderName = json['holderName'];
    number = json['number'];
    cvc = json['cvc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expiryMonth'] = expiryMonth;
    data['expiryYear'] = expiryYear;
    data['holderName'] = holderName;
    data['number'] = number;
    data['cvc'] = cvc;
    return data;
  }
}
