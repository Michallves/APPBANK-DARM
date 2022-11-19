import 'package:appbankdarm/controller/auth_service.dart';
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
    try {
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
      });
    } catch (_) {
      _showModal("passwordError");
      setState(() => isLoading = false);
    }
  }

  _passwordReset() async {
    await context
        .read<AuthService>()
        .passwordReset()
        .then((_) => _showModal("passwordReset"))
        .catchError((_) => _showModal("passwordResetSent"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'senha',
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
      ),
    );
  }

  _showModal(String modalScreen) => showModalBottomSheet(
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
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              modalScreen == 'passwordError'
                                  ? 'Senha incorreta!'
                                  : modalScreen == 'passwordReset'
                                      ? 'Email de recuperação enviado!'
                                      : 'Email de recuperação já foi enviado',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              modalScreen == 'passwordError'
                                  ? 'a senha que você inseriu está incorreta. Recupere a senha ou Tente novamente.'
                                  : 'link de redefinição de senha foi enviado para seu email ${(context.read<AuthService>().email).toString().substring(0, 1)}*****${(context.read<AuthService>().email).toString().substring(7)}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        )),
                  ),
                  modalScreen == 'passwordError'
                      ? BottomButtom(
                          onPress: () {
                            Navigator.of(context).pop();
                            _passwordReset();
                          },
                          title: 'recuperar senha',
                        )
                      : Container(),
                  BottomButtom(
                    onPress: () => {
                      Navigator.of(context).pop(),
                      myFocusNode.requestFocus()
                    },
                    title: modalScreen == "passwordError"
                        ? 'tentar novamente'
                        : 'ok',
                    color: modalScreen == "passwordError"
                        ? Colors.redAccent
                        : Colors.black,
                  ),
                ]),
          ));
}
