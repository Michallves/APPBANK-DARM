import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../services/auth_service.dart';
import '../../../../widgets/bottom_button.dart';
import '../../../../widgets/pin.dart';

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
    await context.read<AuthService>().updatePassword(password.text).then(
        (_) => Navigator.of(context).pushReplacementNamed(AppRoutes.HOME_USER));
  }

  _pressButton() {
    if (context.read<AuthService>().password == password.text) {
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
      body: Column(
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
            loading: isLoading,
            onPress: () => _pressButton(),
            title: 'alterar senha',
            enabled: isButtonActive,
          )
        ],
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
