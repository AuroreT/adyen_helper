import 'package:adyen_helper/adyen_helper.dart';
import 'package:flutter/material.dart';

import 'adyen_form_widget.dart';
import 'encrypted_card_result_widget.dart';

class EncryptCardScreen extends StatefulWidget {
  const EncryptCardScreen({Key? key}) : super(key: key);

  @override
  State<EncryptCardScreen> createState() => _EncryptCardScreenState();
}

class _EncryptCardScreenState extends State<EncryptCardScreen> {
  AdyenEncryptedCardMdl? _finalEncryptcard;

  Future<void> _encryptCard(CreditCardMdl creditCard, String adyenKey) async {
    AdyenHelperManager()
        .encryptCard(card: creditCard, adyenKey: adyenKey)
        .then((value) => _showEncryptionResult(value))
        .onError((error, stackTrace) => _showEncryptionError("$error"));
    if (!mounted) return;
  }

  void _showEncryptionError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(error),
    ));
  }

  void _showEncryptionResult(AdyenEncryptedCardMdl? value) {
    if (value != null) {
      setState(() {
        _finalEncryptcard = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          AdyenFormWidget(
            callback: _encryptCard,
          ),
          const SizedBox(
            height: 20,
          ),
          _finalEncryptcard != null
              ? EncryptedCardResultWidget(
                  encryptedcard: _finalEncryptcard!,
                )
              : Container(),
        ],
      ),
    )));
  }
}
