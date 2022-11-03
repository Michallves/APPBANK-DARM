import 'package:flutter/material.dart';

class CartaoVertical extends StatefulWidget {
  const CartaoVertical(
      {super.key,
      required this.number,
      required this.flag,
      required this.name,
      required this.validity});

  final String number;
  final String flag;
  final String name;
  final String validity;

  @override
  State<CartaoVertical> createState() => _CartaoVerticalState();
}

class _CartaoVerticalState extends State<CartaoVertical> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: (MediaQuery.of(context).size.width - 40) * 0.60,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10)),
      child: Container(
        margin: EdgeInsets.all(
          MediaQuery.of(context).size.width * 0.04,
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(children: [
                Expanded(
                  child: Container(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Image.asset(
                      'assets/images/chip.png',
                      width: MediaQuery.of(context).size.width * 0.17,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: AlignmentDirectional.topEnd,
                    child: widget.flag == 'visa'
                        ? Image.asset(
                            'assets/images/visa.png',
                            width: MediaQuery.of(context).size.width * 0.18,
                            fit: BoxFit.fitWidth,
                          )
                        : widget.flag == 'mastercard'
                            ? Image.asset(
                                'assets/images/mastercard2.png',
                                width: MediaQuery.of(context).size.width * 0.18,
                                fit: BoxFit.fitWidth,
                              )
                            : widget.flag == 'americanexpress'
                                ? Image.asset(
                                    'assets/images/americanexpress.png',
                                    width: MediaQuery.of(context).size.width *
                                        0.14,
                                    fit: BoxFit.fitWidth,
                                  )
                                : widget.flag == 'hipercard'
                                    ? Image.asset(
                                        'assets/images/hipercard.png',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.20,
                                        fit: BoxFit.fitWidth,
                                      )
                                    : widget.flag == 'elo'
                                        ? Image.asset(
                                            'assets/images/elo.png',
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.22,
                                            fit: BoxFit.fitWidth,
                                          )
                                        : null,
                  ),
                ),
              ]),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsetsDirectional.fromSTEB(
                    0, 0, MediaQuery.of(context).size.width * 0.06, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.number.substring(0, 4),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25 * MediaQuery.of(context).textScaleFactor,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          '****',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                34 * MediaQuery.of(context).textScaleFactor,
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          '****',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                34 * MediaQuery.of(context).textScaleFactor,
                          ),
                        )),
                    Text(
                      widget.number.substring(12, 16),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25 * MediaQuery.of(context).textScaleFactor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Titular do cartão',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.025,
                            )),
                        Text(widget.name,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Validade:',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.025,
                            )),
                        Text(widget.validity,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
