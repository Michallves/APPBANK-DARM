import 'package:appbankdarm/components/cartao.dart';
import 'package:flutter/material.dart';

class CartaoRepository {
  static List<Cartao> tabela = [
    const Cartao(
      id: '01',
      flag: 'mastercard',
      number: '4550555456654445',
      name: 'Michael Alves Pereira',
      validity: '14/10',
      cvc: '445',
      type: 'debit&credit',
    ),
    const Cartao(
      id: '02',
      flag: 'visa',
      number: '5555555456654445',
      name: 'Hermeson Alves Pereira',
      validity: '14/10',
      cvc: '445',
      type: 'debit&savings',
    ),
    const Cartao(
      id: '03',
      flag: 'americanexpress',
      number: '5555555456654445',
      name: 'Hermeson Alves Pereira',
      validity: '14/10',
      cvc: '445',
      type: 'credit',
    ),
    const Cartao(
      id: '04',
      flag: 'hipercard',
      number: '5555555456654445',
      name: 'Hermeson Alves Pereira',
      validity: '14/10',
      cvc: '445',
      type: '',
    ),
    const Cartao(
      id: '05',
      flag: 'elo',
      number: '5555555456654445',
      name: 'Hermeson Alves Pereira',
      validity: '14/10',
      cvc: '445',
      type: 'savings',
    ),
  ];
}
