import 'package:appbankdarm/services/auth_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widgets/bottom_button.dart';

class RegisterEmailUser extends StatefulWidget {
  const RegisterEmailUser({super.key});

  @override
  State<RegisterEmailUser> createState() => _RegisterEmailUserState();
}

class _RegisterEmailUserState extends State<RegisterEmailUser> {
  bool isButtonActive = false;
  bool isLoading = false;
  final email = TextEditingController();

  @override
  void initState() {
    super.initState();
    email.addListener(() {
      if (email.text.length > 10) {
        setState(() => isButtonActive = true);
      } else {
        setState(() => isButtonActive = false);
      }
    });
  }

  _pushEmail() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email.text)
        .get()
        .then(
          (res) => {
            if (res.docs.isNotEmpty)
              {
                showModal(),
              }
            else
              {
                context.read<AuthService>().email = email.text,
                Navigator.of(context)
                    .pushNamed(AppRoutes.REGISTER_TELEPHONE_USER)
              }
          },
        );

    setState(() {
      isLoading = false;
    });
  }

  _pressButton() {
    _pushEmail();
  }

  void showModal() => showModalBottomSheet(
       shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      context: context,
      builder: (context) => SizedBox(
            height: 220,
            child: Column(children: [
              const Expanded(
                child: Center(
                  child: Text(
                    'Email já cadastrado',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.all(20),
                child: ElevatedButton(
                    onPressed: () => {
                          setState(() => {
                                isLoading = false,
                              }),
                          Navigator.of(context).pop(),
                        },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[600],
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Tentar novamente')),
              )
            ]),
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'E-mail',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: TextFormField(
                controller: email,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(fontSize: 26),
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  border: InputBorder.none,
                ),
                cursorColor: Colors.black,
              ),
            ),
          ),
          BottomButtom(
            onPress: () => _pressButton(),
            title: 'continuar',
            isButtonActive: isButtonActive,
            isLoading: isLoading,
          )
        ],
      ),
    );
  }
}
