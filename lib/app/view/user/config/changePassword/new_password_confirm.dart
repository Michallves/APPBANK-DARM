import 'package:appbankdarm/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/auth_provider.dart';
import '../../../widgets/bottom_button.dart';
import '../../../widgets/pin.dart';

class NewPasswordConfirm extends StatefulWidget {
  const NewPasswordConfirm({super.key});

  @override
  State<NewPasswordConfirm> createState() => _NewPasswordConfirmState();
}

class _NewPasswordConfirmState extends State<NewPasswordConfirm> {
  bool isButtonActive = false;
  bool isLoading = false;
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

  _changePassword() async {
    setState(() => isLoading = true);
    await context.read<AuthProvider>().updatePassword(password.text).then(
        (_) => Navigator.of(context).pushReplacementNamed(Routes.HOME_USER));
  }

  _pressButton() {
    if (context.read<AuthProvider>().password == password.text) {
      _changePassword();
    } else {
      _showModal();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'confirmar nova senha',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text('digite sua nova senha novamente.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
            ),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Pin(
                    textEditingController: password,
                    focusNode: myFocusNode,
                  )),
            ),
            BottomButtom(
              loading: isLoading,
              onPress: () => _pressButton(),
              title: 'alterar senha',
              enabled: isButtonActive,
            )
          ],
        ),
      ),
    );
  }

  _showModal() => showModalBottomSheet(
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      context: context,
      builder: (context) => SizedBox(
            height: 250,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        'as senhas são diferentes',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'a senha e a confirmação de senha precisam ser exatamentes iguais',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )),
                  BottomButtom(
                    onPress: () => {
                      Navigator.of(context).pop(),
                      myFocusNode.requestFocus(),
                    },
                    title: 'tentar novamente',
                    color: Colors.redAccent,
                  )
                ]),
          ));
}
