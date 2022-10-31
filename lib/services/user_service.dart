import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserService extends ChangeNotifier {
  late User user;
  
  late dynamic userData;
  late String name = 'none';
  
}
