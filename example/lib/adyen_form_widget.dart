import 'package:adyen_helper/mdls/credit_card_mdl.dart';
import 'package:flutter/material.dart';

class AdyenFormWidget extends StatefulWidget {
  final EncryptedCardCallback callback;

  const AdyenFormWidget({Key? key, required this.callback}) : super(key: key);

  @override
  State<AdyenFormWidget> createState() => _AdyenFormWidgetState();
}

class _AdyenFormWidgetState extends State<AdyenFormWidget> {
  final _adyenFormKey = GlobalKey<FormState>();
  String _expiryMonth = "";
  String _expiryYear = "";
  String _holderName = "";
  String _cardNumber = "";
  String _cvc = "";
  String _adyenKey = "";

  void _submitAdyenInfos() {
    if (_adyenFormKey.currentState?.validate() == true) {
      widget.callback(
          CreditCardMdl(
              expiryMonth: _expiryMonth,
              expiryYear: _expiryYear,
              holderName: _holderName,
              number: _cardNumber,
              cvc: _cvc),
          _adyenKey);
    }
  }

  InputDecoration _getFormFieldDecoration(String hintTxt) {
    return InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[500]),
        hintText: hintTxt,
        fillColor: Colors.grey[200]);
  }

  TextStyle get _inputTextStyle => const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);

    return Form(
      key: _adyenFormKey,
      child: Column(
        children: <Widget>[
          const Text(
            "Card informations",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (String value) => _holderName = value,
            decoration: _getFormFieldDecoration("Holder name"),
            style: _inputTextStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (String value) => _cardNumber = value,
            decoration: _getFormFieldDecoration(
              'Card number',
            ),
            style: _inputTextStyle,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: _mediaQueryData.size.width / 2.2,
                child: TextFormField(
                  onChanged: (String value) => _expiryMonth = value,
                  decoration: _getFormFieldDecoration(
                    'Expiry month (MM)',
                  ),
                  style: _inputTextStyle,
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                width: _mediaQueryData.size.width / 2.2,
                child: TextFormField(
                  onChanged: (String value) => _expiryYear = value,
                  decoration: _getFormFieldDecoration(
                    'Expiry year (YYYY)',
                  ),
                  style: _inputTextStyle,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (String value) => _cvc = value,
            decoration: _getFormFieldDecoration(
              'CVC',
            ),
            style: _inputTextStyle,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (String value) => _adyenKey = value,
            decoration: _getFormFieldDecoration(
              'Adyen key',
            ),
            style: _inputTextStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: _submitAdyenInfos,
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 12)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide.none)),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff92A3FE))),
              child: const Text(
                'Submit',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

typedef EncryptedCardCallback = void Function(CreditCardMdl, String);
