import 'dart:io';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:appbankdarm/widgets/bottom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../services/auth_service.dart';
import '../../../services/user_service.dart';

class AccountUser extends StatefulWidget {
  const AccountUser({super.key});

  @override
  State<AccountUser> createState() => _AccountUserState();
}

class _AccountUserState extends State<AccountUser> {
  String? name;
  String? image;
  bool isLoading = true;

  @override
  void initState() {
    setState(() {
      name = context.read<UserService>().name;
      image = context.read<UserService>().image;
      isLoading = false;
    });
    super.initState();
  }

  _pressButton() {
    Navigator.of(context).pushNamed(AppRoutes.HOMEUSER);
  }

  removeImage() async {
    await FirebaseStorage.instance.refFromURL(image!).delete();
  }

  _uploadUrl(image) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<AuthService>().usuario?.uid)
        .update({'image': image});
  }

  Future<void> upload(String path) async {
    File file = File(path);
    FirebaseStorage storage = FirebaseStorage.instance;
    String ref = '/users/${context.read<AuthService>().usuario?.uid}/user.jpg';
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
          ? const Center(
              child: CircularProgressIndicator(color: Colors.black),
            )
          : Column(
              children: [
                Expanded(
                  child: SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: _showModal,
                            child: CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.black,
                                backgroundImage: NetworkImage(image!),
                                child: image == ''
                                    ? Text(
                                        name
                                            .toString()
                                            .substring(0, 2)
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 80),
                                      )
                                    : null),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(name.toString(),
                              style: const TextStyle(fontSize: 25))
                        ],
                      )),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: ElevatedButton(
                    onPressed: () => _pressButton(),
                    child: const Text("alterar senha"),
                  ),
                ),
                BottomButtom(
                    onPress: () =>
                        Navigator.of(context).pushNamed(AppRoutes.DELETE_USER),
                    title: "excluir conta",
                    color: Colors.redAccent),
              ],
            ),
    );
  }

  _showModal() => showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      context: context,
      builder: (context) => SizedBox(
            height: 250,
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
                image != null
                    ? ListTile(
                        iconColor: Colors.redAccent,
                        textColor: Colors.redAccent,
                        title: const Text('Remover'),
                        leading: const Icon(
                          Icons.delete_outline,
                        ),
                        onTap: removeImage,
                      )
                    : Container()
              ],
            ),
          ));
}
