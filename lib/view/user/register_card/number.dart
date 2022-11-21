import 'package:appbankdarm/utils/app_routes.dart';
import 'package:appbankdarm/widgets/bottom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../services/card_service.dart';
import '../../../services/user_service.dart';

class RegisterCardNumber extends StatefulWidget {
  const RegisterCardNumber({super.key});

  @override
  State<RegisterCardNumber> createState() => _RegisterCardNumberState();
}

class _RegisterCardNumberState extends State<RegisterCardNumber> {
  bool isButtonActive = false;
  bool isLoading = false;
  String flag = '';
  final number = TextEditingController();
  final formFieldKey = GlobalKey<FormFieldState>();
  late FocusNode myFocusNode;
  bool labelErr = false;

  @override
  void initState() {
    myFocusNode = FocusNode();
    number.addListener(() {
      if (number.text.length == 19) {
        _validateFlag();
        setState(() {
          isButtonActive = true;
        });
      } else {
        setState(() {
          flag = '';
          isButtonActive = false;
          formFieldKey.currentState?.validate();
        });
      }
    });
    super.initState();
  }

  _validateFlag() {
    setState(() {
      flag = CreditCardValidator().validateCCNum(number.text).ccType.name;
    });
  }

  _navigator() {
    context.read<CardService>().number =
        UtilBrasilFields.removeCaracteres(number.text);
    context.read<CardService>().flag = flag;
    Navigator.of(context).pushNamed(AppRoutes.REGISTER_CARD_CVC);
  }

  _getNumber() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(context.read<UserService>().auth.usuario?.uid)
        .collection('cards')
        .where("number",
            isEqualTo: UtilBrasilFields.removeCaracteres(number.text))
        .get()
        .then(
          (res) => {
            if (res.docs.isNotEmpty)
              {
                showModal(),
              }
            else
              {_navigator()}
          },
        );
    setState(() {
      isLoading = false;
    });
  }

  _validateNumber() {
    formFieldKey.currentState?.validate();
    setState(() => isLoading = false);
  }

  _pressButton() async {
    setState(() {
      isLoading = true;
    });
    CreditCardValidator().validateCCNum(number.text).isValid == true
        ? {_getNumber()}
        : {_validateNumber()};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'número do cartão',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 120,
                          child: TextFormField(
                            key: formFieldKey,
                            controller: number,
                            keyboardType: TextInputType.number,
                            focusNode: myFocusNode,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CartaoBancarioInputFormatter(),
                            ],
                            validator: (String? value) {
                              if (CreditCardValidator()
                                          .validateCCNum(number.text)
                                          .isValid ==
                                      false &&
                                  number.text.length == 19 &&
                                  flag != '') {
                                setState(() {
                                  labelErr = true;
                                });
                                return 'Número inválido. confira e tente novamente';
                              } else {
                                labelErr = false;
                              }
                            },
                            autofocus: true,
                            style: TextStyle(
                              fontSize: 26,
                              color:
                                  labelErr == true ? Colors.red : Colors.black,
                            ),
                            decoration: InputDecoration(
                              hintText: '0000 0000 0000 0000',
                              labelStyle: TextStyle(
                                color: labelErr == true
                                    ? Colors.red
                                    : Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              errorStyle: const TextStyle(
                                color: Colors.red,
                              ),
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.black,
                          )),
                      Container(
                        height: 50,
                        width: 80,
                        alignment: AlignmentDirectional.center,
                        child: flag == 'mastercard'
                            ? Image.asset(
                                'assets/images/mastercard2.png',
                                width: 70,
                                fit: BoxFit.fitWidth,
                              )
                            : flag == 'visa'
                                ? Image.asset(
                                    'assets/images/visa2.png',
                                    width: 70,
                                    fit: BoxFit.fitWidth,
                                  )
                                : flag == 'elo'
                                    ? Image.asset(
                                        'assets/images/elo2.png',
                                        width: 90,
                                        fit: BoxFit.fitWidth,
                                      )
                                    : flag == 'hipercard'
                                        ? Image.asset(
                                            'assets/images/hipercard.png',
                                            width: 90,
                                            fit: BoxFit.fitWidth,
                                          )
                                        : flag == 'amex'
                                            ? Image.asset(
                                                'assets/images/americanexpress.png',
                                                width: 60,
                                                fit: BoxFit.fitWidth,
                                              )
                                            : Container(),
                      ),
                    ],
                  )),
            ),
            BottomButtom(
                enabled: isButtonActive,
                onPress: () => _pressButton(),
                title: "continuar")
          ],
        ),
      ),
    );
  }

  void showModal() => showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      isScrollControlled: false,
      context: context,
      builder: (context) => SizedBox(
            height: 220,
            child: Column(children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    'Cartão já cadastrado',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'toque em "tentar novamente".',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              )),
              BottomButtom(
                  loading: isLoading,
                  onPress: () => {
                        Navigator.of(context).pop(),
                        number.clear(),
                        myFocusNode.requestFocus(),
                      },
                  title: 'tentar novamente')
            ]),
          ));
}
