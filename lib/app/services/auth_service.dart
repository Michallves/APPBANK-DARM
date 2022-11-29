import 'package:appbankdarm/app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;
  User? usuario;
  final Rxn<User> _firebaseUser = Rxn<User>();

  User? get user => _firebaseUser.value;
  static AuthService get to => Get.put(AuthService());

  Future login({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  registerUser({required UserModel user, required String password}) async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: user.email!,
      password: password,
    )
        .then((UserCredential userCredential) async {
      registerUserDB(userCredential: userCredential, user: user);
    });
  }

  registerUserDB(
      {required UserCredential userCredential, required UserModel user}) async {
    await _firebaseDB.collection("users").doc(userCredential.user?.uid).set({
      "cpf": user.cpf,
      'name': user.name,
      "email": user.email,
      "telephone": user.telephone,
      "accountType": user.accountType,
      "image": '',
      "address": {
        'state': user.address?.state,
        "city": user.address?.city,
        "district": user.address?.district,
        "street": user.address?.street,
        "number": user.address?.number,
      },
    });
  }

  logout() async {
    await _firebaseAuth.signOut();
  }

  Future reAuth(String password) async {
    UserCredential reAuth = await usuario!.reauthenticateWithCredential(
        EmailAuthProvider.credential(
            email: usuario!.email!, password: password));
    _getUser();
    return reAuth;
  }

  Future updatePassword(String password) async {
    return await usuario?.updatePassword(password);
  }

  Future forgotPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  getEmail(String? cpf) async {
    var snapshot = await _firebaseDB
        .collection("users")
        .where("cpf", isEqualTo: cpf)
        .get();
    for (var doc in snapshot.docs) {
      {
        return doc.get("email");
      }
    }
  }

  Future deleteAccount() async {
    void deleteUser = await usuario?.delete();
    await _firebaseDB.collection('users').doc(usuario?.uid).delete();
    return deleteUser;
  }

  _getUser() {
    usuario = _firebaseAuth.currentUser;
  }
}
