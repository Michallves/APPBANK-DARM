import 'package:appbankdarm/utils/app_routes.dart';
import 'package:appbankdarm/widgets/bottom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  late FocusNode myFocusNode;

  @override
  void initState() {
    myFocusNode = FocusNode();
    number.addListener(() {
      var numberText = UtilBrasilFields.removeCaracteres(number.text);
      var oneDig = numberText.substring(0, 1);
      var twoDig = numberText.substring(0, 2);
      var sixDig = numberText.substring(0, 6);
      if (numberText.length == 16 &&
          int.parse(twoDig) >= 51 &&
          int.parse(twoDig) <= 55) {
        setState(() => {flag = "mastercard", isButtonActive = true});
      } else if (numberText.length == 16 && oneDig == "4") {
        setState(() => {flag = "visa", isButtonActive = true});
      } else if (numberText.length == 16 &&
          int.parse(twoDig) >= 34 &&
          int.parse(twoDig) <= 37) {
        setState(() => {flag = "americanexpress", isButtonActive = true});
      } else if (numberText.length == 16 && sixDig == "384100" ||
          sixDig == "384140" ||
          sixDig == "384160" ||
          sixDig == "606282" ||
          sixDig == "637095" ||
          sixDig == "637568" ||
          sixDig == "637599" ||
          sixDig == "637609" ||
          sixDig == "637612") {
        setState(() => {flag = "hipercard", isButtonActive = true});
      } else if (numberText.length == 16 && sixDig == "401178" ||
          sixDig == "401179" ||
          sixDig == "431274" ||
          sixDig == "438935" ||
          sixDig == "451416" ||
          sixDig == "457393" ||
          sixDig == "457631" ||
          sixDig == "457632" ||
          sixDig == "504175" ||
          (int.parse(sixDig) >= 506699 && int.parse(sixDig) <= 506778) ||
          (int.parse(sixDig) >= 509000 && int.parse(sixDig) <= 509999) ||
          sixDig == "627780" ||
          sixDig == "636297" ||
          sixDig == "636368" ||
          (int.parse(sixDig) >= 650035 && int.parse(sixDig) <= 650051) ||
          (int.parse(sixDig) >= 650405 && int.parse(sixDig) <= 650439) ||
          (int.parse(sixDig) >= 650485 && int.parse(sixDig) <= 650538) ||
          (int.parse(sixDig) >= 650541 && int.parse(sixDig) <= 650598) ||
          (int.parse(sixDig) >= 650700 && int.parse(sixDig) <= 650718) ||
          (int.parse(sixDig) >= 650720 && int.parse(sixDig) <= 650727) ||
          (int.parse(sixDig) >= 650901 && int.parse(sixDig) <= 650978) ||
          (int.parse(sixDig) >= 651652 && int.parse(sixDig) <= 651679) ||
          (int.parse(sixDig) >= 655000 && int.parse(sixDig) <= 655019) ||
          (int.parse(sixDig) >= 655021 && int.parse(sixDig) <= 655058) ||
          (int.parse(sixDig) >= 650031 && int.parse(sixDig) <= 650033)) {
        setState(() => {flag = "elo", isButtonActive = true});
      } else {
        setState(() => {isButtonActive = false, flag = ""});
      }
    });
    super.initState();
  }

  _pressButton() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(context.read<UserService>().user?.uid)
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
              {
                context.read<CardService>().number =
                    UtilBrasilFields.removeCaracteres(number.text),
                context.read<CardService>().flag = flag,
                Navigator.of(context).pushNamed(AppRoutes.REGISTER_CARD_CVC),
              }
          },
        );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'número do cartão',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 140,
                        child: TextField(
                          controller: number,
                          keyboardType: TextInputType.number,
                          focusNode: myFocusNode,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CartaoBancarioInputFormatter(),
                          ],
                          autofocus: true,
                          style: const TextStyle(fontSize: 26),
                          decoration: const InputDecoration(
                            hintText: '0000 0000 0000 0000',
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.black,
                        )),
                    Container(
                      height: 50,
                      width: 100,
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
                                      : flag == 'americanexpress'
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
              onPress: () => isButtonActive == true ? _pressButton() : null,
              title: "continuar")
        ],
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
