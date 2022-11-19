import 'dart:io';
import 'package:appbankdarm/widgets/info_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../controller/user_service.dart';

class AccountUser extends StatefulWidget {
  const AccountUser({super.key});

  @override
  State<AccountUser> createState() => _AccountUserState();
}

class _AccountUserState extends State<AccountUser> {
  bool isLoading = true;
  DocumentSnapshot<Object?>? user;
  @override
  void initState() {
    super.initState();
    _readUser();
  }

  _readUser() async {
    try {
      await context.read<UserService>().readUser();
    } finally {
      user = context.read<UserService>().user;
      setState(() => isLoading = false);
    }
  }

  _uploadUrl(image) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<UserService>().auth.usuario?.uid)
        .update({'image': image});
  }

  Future<void> upload(String path) async {
    File file = File(path);
    FirebaseStorage storage = FirebaseStorage.instance;
    String ref =
        '/users/${context.read<UserService>().auth.usuario?.uid}/user.jpg';
    await storage.ref(ref).putFile(file).then((_) =>
        storage.ref(ref).getDownloadURL().then((url) => _uploadUrl(url)));
  }

  Future<XFile?> getImageGallery() async {
    final ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      await upload(file.path);
    }
    return null;
  }

  Future<XFile?> getImageCamera() async {
    final ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.camera);
    if (file != null) {
      await upload(file.path);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'conta',
          ),
        ),
        body: isLoading == true
            ? const SafeArea(
                child: Center(
                  child: CircularProgressIndicator(color: Colors.black),
                ),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                          height: 180,
                          child: GestureDetector(
                            onTap: _showModal,
                            child: CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.black,
                                backgroundImage:
                                    NetworkImage((user?['image']).toString()),
                                child: user?['image'] == ''
                                    ? Text(
                                        (user?['name'])
                                            .toString()
                                            .substring(0, 2)
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 80),
                                      )
                                    : null),
                          )),
                      InfoUser(
                        name: user?['name'],
                        cpf: user?['cpf'],
                        number: user?['telephone'],
                        email: user?['email'],
                        typeAccount: user?['accountType'],
                      ),
                    ],
                  ),
                ),
              ));
  }

  _showModal() => showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      context: context,
      builder: (context) => SizedBox(
            height: 200,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      'Adicionar Imagem',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const Divider(height: 2),
                ListTile(
                  iconColor: Colors.black,
                  title: const Text('Camera'),
                  leading: const Icon(Icons.camera_alt_outlined),
                  onTap: getImageCamera,
                ),
                ListTile(
                  iconColor: Colors.black,
                  title: const Text('Galeria'),
                  leading: const Icon(
                    Icons.image_outlined,
                  ),
                  onTap: getImageGallery,
                ),
              ],
            ),
          ));
}
