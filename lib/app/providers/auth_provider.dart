import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthProvider extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;
  User? usuario;
  final Rxn<User> _firebaseUser = Rxn<User>();

  User? get user => _firebaseUser.value;
  static AuthProvider get to => Get.find<AuthProvider>();

  Future login({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  registerUser(
      {required String email,
      required String password,
      required String name,
      required String cpf,
      required String telephone,
      required String accountType,
      required String state,
      required String city,
      required String district,
      required String street,
      required String number}) async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((UserCredential userCredential) async {
      await _firebaseDB.collection("users").doc(userCredential.user?.uid).set({
        "cpf": cpf,
        'name': name,
        "email": email,
        "telephone": telephone,
        "accountType": accountType,
        "image": '',
        "address": {
          'state': state,
          "city": city,
          "district": district,
          "street": street,
          "number": number,
        },
      });
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

  getEmail(String cpf) async {
    String? email;
    await _firebaseDB
        .collection("users")
        .where("cpf", isEqualTo: cpf)
        .get()
        .then((snapshot) => {
              snapshot.docs.forEach((doc) => {
                    email = doc.get('email'),
                  })
            }); 
    return email;
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
