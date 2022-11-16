import 'package:appbankdarm/services/auth_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/bottom_button.dart';
import '../../widgets/pin.dart';

class LoginPasswordUser extends StatefulWidget {
  const LoginPasswordUser({super.key});

  @override
  State<LoginPasswordUser> createState() => _LoginPasswordUserState();
}

class _LoginPasswordUserState extends State<LoginPasswordUser> {
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

  _login() async {
    setState(() => isLoading = true);
    AuthService auth = context.read<AuthService>();

    await context.read<AuthService>().login(password.text).then((_) {
      if (auth.role == 'user') {
        setState(() {
          Navigator.of(context).pushReplacementNamed(AppRoutes.HOME_USER);
        });
      } else if (auth.role == 'admin') {
        setState(() {
          Navigator.of(context).pushReplacementNamed(AppRoutes.HOME_ADMIN);
        });
      }
    }).catchError((_) {
      _showModal();
      setState(() => isLoading = false);
    });
  }

  _passwordReset() async {
    await context.read<AuthService>().passwordReset();
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
                child: Pin(
                  textEditingController: password,
                  focusNode: myFocusNode,
                )),
          ),
          Container(
              margin: const EdgeInsets.all(20),
              child: TextButton(
                  onPressed: () => _passwordReset(),
                  child: const Text(
                    'recuperar conta',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ))),
          BottomButtom(
            onPress: () => _login(),
            title: 'entrar',
            enabled: isButtonActive,
            loading: isLoading,
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
                        'Senha incorreta!',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'a senha que você inseriu está incorreta. Tente novamente.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )),
                  BottomButtom(
                    onPress: () => {
                      Navigator.of(context).pop(),
                      myFocusNode.requestFocus()
                    },
                    title: 'tentar novamente',
                    color: Colors.redAccent,
                  ),
                ]),
          ));
}
