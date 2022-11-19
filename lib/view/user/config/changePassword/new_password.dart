import 'package:appbankdarm/controller/auth_service.dart';
import 'package:appbankdarm/widgets/pin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/app_routes.dart';
import '../../../../widgets/bottom_button.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  bool isButtonActive = false;
  final password = TextEditingController();
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
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
    Navigator.of(context).pushNamed(AppRoutes.NEW_PASSWORD_CONFIRM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'nova senha',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Pin(
                    textEditingController: password,
                    focusNode: myFocusNode,
                  )),
            ),
            BottomButtom(
              onPress: () => _pressButton(),
              title: 'continuar',
              enabled: isButtonActive,
            )
          ],
        ),
      ),
    );
  }
}
