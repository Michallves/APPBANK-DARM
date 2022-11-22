import 'dart:math';
import 'package:flutter/material.dart';
import '../../models/card_model.dart';

class CartaoCard extends StatefulWidget {
  final Cartao cartao;
  const CartaoCard(
    this.cartao, {
    super.key,
    this.obscure,
    this.animation,
  });

  final bool? obscure;
  final bool? animation;

  @override
  State<CartaoCard> createState() => _CartaoCardState();
}

class _CartaoCardState extends State<CartaoCard> with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;

  bool front = true;
  double horizontalDrag = 0;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    super.initState();
  }

  void setCardSide() {
    if (horizontalDrag <= 90 || horizontalDrag >= 270) {
      front = true;
    } else {
      front = false;
    }
    if (horizontalDrag > 360) {
      setState(() {
        horizontalDrag = 0;
      });
    }
  }

  bool isAnimation = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragStart: widget.animation == true
            ? (details) {
                if (horizontalDrag <= 90 || horizontalDrag >= 270) {
                  controller?.reset();
                  setState(() {
                    horizontalDrag = 0;
                    setCardSide();
                  });
                } else {
                  setState(() {
                    horizontalDrag = 180;
                    setCardSide();
                  });
                }
              }
            : null,
        onHorizontalDragEnd: widget.animation == true
            ? (details) {
                final double end = 360 - horizontalDrag >= 180 ? 0 : 360;
                animation = Tween<double>(begin: horizontalDrag, end: end)
                    .animate(controller!)
                  ..addListener(() {
                    setState(() {
                      horizontalDrag = animation!.value;
                    });
                  });
              }
            : null,
        onHorizontalDragUpdate: widget.animation == true
            ? (details) {
                setState(() {
                  horizontalDrag -= details.delta.dx;
                  horizontalDrag %= 360;
                  setCardSide();
                });
              }
            : null,
        child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0007)
              ..rotateY(horizontalDrag / 180 * pi),
            child: front == true
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: (MediaQuery.of(context).size.width - 40) * 0.60,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
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
                                    width: MediaQuery.of(context).size.width *
                                        0.17,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: AlignmentDirectional.topEnd,
                                  child: widget.cartao.flag == 'visa'
                                      ? Image.asset(
                                          'assets/images/visa.png',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.18,
                                          fit: BoxFit.fitWidth,
                                        )
                                      : widget.cartao.flag == 'mastercard'
                                          ? Image.asset(
                                              'assets/images/mastercard2.png',
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.18,
                                              fit: BoxFit.fitWidth,
                                            )
                                          : widget.cartao.flag ==
                                                  'americanexpress'
                                              ? Image.asset(
                                                  'assets/images/americanexpress.png',
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.14,
                                                  fit: BoxFit.fitWidth,
                                                )
                                              : widget.cartao.flag ==
                                                      'hipercard'
                                                  ? Image.asset(
                                                      'assets/images/hipercard.png',
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.20,
                                                      fit: BoxFit.fitWidth,
                                                    )
                                                  : widget.cartao.flag == 'elo'
                                                      ? Image.asset(
                                                          'assets/images/elo.png',
                                                          width: MediaQuery.of(
                                                                      context)
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
                              margin: EdgeInsetsDirectional.fromSTEB(0, 0,
                                  MediaQuery.of(context).size.width * 0.06, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.cartao.number!.substring(0, 4),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25 *
                                          MediaQuery.of(context)
                                              .textScaleFactor,
                                    ),
                                  ),
                                  (widget.obscure == false
                                      ? Text(
                                          widget.cartao.number!.substring(4, 8),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25 *
                                                MediaQuery.of(context)
                                                    .textScaleFactor,
                                          ))
                                      : Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 0),
                                          child: Text(
                                            '****',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 34 *
                                                  MediaQuery.of(context)
                                                      .textScaleFactor,
                                            ),
                                          ))),
                                  (widget.obscure == false
                                      ? Text(
                                          widget.cartao.number!
                                              .substring(8, 12),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25 *
                                                MediaQuery.of(context)
                                                    .textScaleFactor,
                                          ))
                                      : Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 0),
                                          child: Text(
                                            '****',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 34 *
                                                  MediaQuery.of(context)
                                                      .textScaleFactor,
                                            ),
                                          ))),
                                  Text(
                                    widget.cartao.number!.substring(12, 16),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25 *
                                          MediaQuery.of(context)
                                              .textScaleFactor,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Titular do cartão',
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.025,
                                          )),
                                      Text(widget.cartao.name!,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
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
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.025,
                                          )),
                                      Text(widget.cartao.validity!,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
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
                  )
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: (MediaQuery.of(context).size.width - 40) * 0.60,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: [
                        Container(
                          color: Colors.white70,
                          height: MediaQuery.of(context).size.width * 0.12,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.width * 0.05),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.04),
                            child: Row(
                              children: [
                                Expanded(
                                    child: (widget.cartao.type != ''
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Tipo de cartão',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.025,
                                                  )),
                                              Text(
                                                  widget.cartao.type == 'debit'
                                                      ? 'Débito'
                                                      : widget.cartao.type ==
                                                              'credit'
                                                          ? 'Crédito'
                                                          : widget.cartao
                                                                      .type ==
                                                                  'savings'
                                                              ? 'Poupança'
                                                              : widget.cartao
                                                                          .type ==
                                                                      'credit&debit'
                                                                  ? 'Débito e Crédito'
                                                                  : widget.cartao
                                                                              .type ==
                                                                          'debit&savings'
                                                                      ? 'Débito e Poupança'
                                                                      : '',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                  ))
                                            ],
                                          )
                                        : Container())),
                                Expanded(
                                  child: widget.cartao.cvc != null
                                      ? Container(
                                          alignment:
                                              AlignmentDirectional.bottomEnd,
                                          child: Container(
                                            color: Colors.white,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.18,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.13,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('CVC',
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.025,
                                                    )),
                                                Text(widget.cartao.cvc!,
                                                    maxLines: 1,
                                                    textAlign: TextAlign.right,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    ))));
  }
}
