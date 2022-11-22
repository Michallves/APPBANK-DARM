import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class Pin extends StatelessWidget {
  Pin({super.key, required this.textEditingController, this.focusNode});
  TextEditingController textEditingController = TextEditingController();
  FocusNode? focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: textEditingController,
      focusNode: focusNode,
      keyboardType: TextInputType.number,
      errorBorderColor: Colors.red,
      pinBoxWidth: 35,
      pinBoxHeight: 50,
      pinBoxRadius: 10,
      pinBoxOuterPadding: const EdgeInsets.symmetric(horizontal: 10),
      wrapAlignment: WrapAlignment.spaceAround,
      maxLength: 6,
      hideCharacter: true,
      maskCharacter: '•',
      pinTextStyle: const TextStyle(fontSize: 20),
      highlight: true,
      defaultBorderColor: Colors.black38,
      hasTextBorderColor: Colors.black38,
    );
  }
}
