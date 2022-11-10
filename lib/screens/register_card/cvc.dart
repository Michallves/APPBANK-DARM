import 'package:appbankdarm/services/card_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

import '../../widgets/bottom_button.dart';

class RegisterCardCvc extends StatefulWidget {
  const RegisterCardCvc({super.key});

  @override
  State<RegisterCardCvc> createState() => _RegisterCardCvcState();
}

class _RegisterCardCvcState extends State<RegisterCardCvc> {
  bool isButtonActive = false;
  final cvc = TextEditingController();
  late FocusNode myFocusNode;
  @override
  void initState() {
    myFocusNode = FocusNode();
    myFocusNode.requestFocus();
    cvc.addListener(() {
      if (cvc.text.length == 3) {
        setState(() => isButtonActive = true);
      } else {
        setState(() => isButtonActive = false);
      }
    });
    super.initState();
  }

  _pressButton() {
    context.read<CardService>().cvc = cvc.text;
    Navigator.of(context).pushNamed(AppRoutes.REGISTER_CARD_VALIDITY);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CVC',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 40),
              child: PinCodeTextField(
                focusNode: myFocusNode,
                controller: cvc,
                keyboardType: TextInputType.number,
                errorBorderColor: Colors.red,
                pinBoxWidth: 35,
                pinBoxHeight: 50,
                pinBoxRadius: 10,
                pinBoxOuterPadding: const EdgeInsets.symmetric(horizontal: 10),
                wrapAlignment: WrapAlignment.spaceAround,
                maxLength: 3,
                pinTextStyle: const TextStyle(fontSize: 20),
                highlight: true,
                defaultBorderColor: Colors.black38,
                hasTextBorderColor: Colors.black38,
              ),
            ),
          ),
          BottomButtom(
              enabled: isButtonActive,
              onPress: () => isButtonActive == true ? _pressButton() : null,
              title: "continuar")
        ],
      ),
    );
  }
}
