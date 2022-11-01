import 'package:appbankdarm/services/auth_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

import '../../../widgets/bottom_button.dart';

class RegisterPasswordUser extends StatefulWidget {
  const RegisterPasswordUser({super.key});

  @override
  State<RegisterPasswordUser> createState() => _RegisterPasswordUserState();
}

class _RegisterPasswordUserState extends State<RegisterPasswordUser> {
  bool isButtonActive = false;
  final password = TextEditingController();
  late FocusNode myFocusNode;

  @override
  void initState() {
    myFocusNode = FocusNode();
    myFocusNode.requestFocus();
    password.addListener(() {
      if (password.text.length == 6) {
        setState(() => isButtonActive = true);
      } else {
        setState(() => isButtonActive = false);
      }
    });
    super.initState();
  }

  _pressButton() {
    context.read<AuthService>().password = password.text;
    Navigator.of(context).pushNamed(AppRoutes.REGISTER_PASSWORD_AGAIN_USER);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'senha',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 40),
              child: PinCodeTextField(
                controller: password,
                keyboardType: TextInputType.number,
                errorBorderColor: Colors.red,
                focusNode: myFocusNode,
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
              ),
            ),
          ),
          BottomButtom(
            onPress: () => _pressButton(),
            title: 'continuar',
            enabled: isButtonActive,
          )
        ],
      ),
    );
  }
}
