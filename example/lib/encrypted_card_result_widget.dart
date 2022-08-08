import 'package:adyen_helper/mdls/adyen_encrypted_card_mdl.dart';
import 'package:flutter/material.dart';

class EncryptedCardResultWidget extends StatelessWidget {
  final AdyenEncryptedCardMdl encryptedcard;

  TextStyle get _titleTextStyle => const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14);
  TextStyle get _contentTextStyle =>
      const TextStyle(color: Colors.black, fontSize: 11);

  const EncryptedCardResultWidget({Key? key, required this.encryptedcard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);

    Widget _getFieldCard(String label, String field) {
      return SizedBox(
        width: _mediaQueryData.size.width / 2.1,
        height: _mediaQueryData.size.height / 4,
        child: Card(
          color: Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: _titleTextStyle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  field,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: _contentTextStyle,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: [
          _getFieldCard(
              "Encrypted card number :", encryptedcard.encryptedCardNumber),
          _getFieldCard(
              "Encrypted card month :", encryptedcard.encryptedExpiryMonth),
          _getFieldCard(
              "Encrypted card year :", encryptedcard.encryptedExpiryYear),
          _getFieldCard(
              "Encrypted card CVC :", encryptedcard.encryptedSecurityCode),
        ],
      ),
    );
  }
}
