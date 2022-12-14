import 'package:appbankdarm/app/services/auth_service.dart';
import 'package:appbankdarm/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widgets/bottom_button.dart';
import '../../../widgets/pin.dart';

class CurrentPassword extends StatefulWidget {
  const CurrentPassword({super.key});

  @override
  State<CurrentPassword> createState() => _CurrentPasswordState();
}

class _CurrentPasswordState extends State<CurrentPassword> {
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

  _reAuth() async {
    setState(() => isLoading = true);
    context.read<AuthService>().reAuth(password.text).then((_) {
      Navigator.of(context).pushNamed(Routes.NEW_PASSWORD);
      setState(() => isLoading = false);
    }).catchError((_) {
      setState(() => isLoading = false);
      _showModal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'senha atual',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text('digite sua senha atual para alterá-la.',
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
              onPress: () => _reAuth(),
              title: 'continuar',
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
            child: Column(children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    'Senha incorreta!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  setState(() => {
                        isLoading = false,
                      }),
                  Navigator.of(context).pop(),
                  myFocusNode.requestFocus(),
                },
                title: 'tentar novamente',
                color: Colors.redAccent,
              )
            ]),
          ));
}
