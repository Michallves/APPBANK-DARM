import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard(
      {super.key,
      required this.name,
      required this.number,
      required this.validity,
      required this.cvc,
      required this.flag,
      this.type});

  final String? name;
  final String? number;
  final String? validity;
  final String? cvc;
  final String? flag;
  final String? type;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Nome',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                Text(
                  name!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          SizedBox(
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Número',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                Text(
                  '${number!.substring(0, 4)}  ${number!.substring(4, 8)}  ${number!.substring(8, 12)}  ${number!.substring(12, 16)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Row(
            children: [
              SizedBox(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Validade',
                        style:
                            TextStyle(fontSize: 16, color: Colors.grey[700])),
                    Text(
                      validity!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(40)),
              SizedBox(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('CVC',
                        style:
                            TextStyle(fontSize: 16, color: Colors.grey[700])),
                    Text(
                      cvc!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
          const Divider(
            height: 1,
          ),
          Row(
            children: [
              SizedBox(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Bandeira',
                        style:
                            TextStyle(fontSize: 16, color: Colors.grey[700])),
                    Text(
                      flag == 'visa'
                          ? 'Visa'
                          : flag == 'mastercard'
                              ? 'Mastercard'
                              : flag == 'americanexpress'
                                  ? 'American Express'
                                  : flag == 'hipercard'
                                      ? 'Hipercard'
                                      : flag == 'elo'
                                          ? 'Elo'
                                          : '',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(40)),
              type != ''
                  ? SizedBox(
                      height: 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Tipo de cartão',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[700])),
                          Text(
                            type == 'debit'
                                ? 'Débito'
                                : type == 'credit'
                                    ? 'Crédito'
                                    : type == 'savings'
                                        ? 'Poupança'
                                        : type == 'credit&debit'
                                            ? 'Débito e Crédito'
                                            : type == 'debit&savings'
                                                ? 'Débito e Poupança'
                                                : '',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  : Container()
            ],
          )
        ],
      ),
    );
  }
}
