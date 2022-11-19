import 'package:appbankdarm/controller/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_routes.dart';
import '../../widgets/bottom_button.dart';
import '../../widgets/pin.dart';

class RegisterPasswordConfirm extends StatefulWidget {
  const RegisterPasswordConfirm({super.key});

  @override
  State<RegisterPasswordConfirm> createState() =>
      _RegisterPasswordConfirmState();
}

class _RegisterPasswordConfirmState extends State<RegisterPasswordConfirm> {
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

  _register() async {
    setState(() => isLoading = true);
    AuthService auth = context.read<AuthService>();
    try {
      context.read<AuthService>().register(password.text).then((_) {
        if (auth.role == 'user') {
          Navigator.of(context).pushReplacementNamed(AppRoutes.HOME_USER);
        } else {
          Navigator.of(context).pushReplacementNamed(AppRoutes.HOME_ADMIN);
        }
      });
    } catch (_) {
      showModal();
      setState(() => isLoading = false);
    }
  }

  _pressButton() {
    if (context.read<AuthService>().password == password.text) {
      _register();
    } else {
      showModal();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'senha novamente',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 40),
                  child: Pin(
                    textEditingController: password,
                    focusNode: myFocusNode,
                  )),
            ),
            BottomButtom(
              onPress: () => _pressButton(),
              title: 'criar conta',
              enabled: isButtonActive,
              loading: isLoading,
            )
          ],
        ),
      ),
    );
  }

  void showModal() => showModalBottomSheet(
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      context: context,
      builder: (context) => SizedBox(
            height: 280,
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
