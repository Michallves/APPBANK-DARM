import 'dart:io';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../services/user_service.dart';

class AccountUser extends StatefulWidget {
  const AccountUser({super.key});

  @override
  State<AccountUser> createState() => _AccountUserState();
}

class _AccountUserState extends State<AccountUser> {
  bool isButtonActive = false;

  _pressButton() {
    Navigator.of(context).pushNamed(AppRoutes.HOMEUSER);
  }

  File? _image;

  Future<void> _pickImageCamera() async {
    final picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      () => Navigator.of(context).pop();
    }
  }

  Future<void> _pickImageGallery() async {
    final picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      () => Navigator.of(context).pop();
    }
  }

  void showModal() => showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
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
                  onTap: _pickImageCamera,
                ),
                ListTile(
                  iconColor: Colors.black,
                  title: const Text('Galeria'),
                  leading: const Icon(
                    Icons.image_outlined,
                  ),
                  onTap: _pickImageGallery,
                )
              ],
            ),
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'conta',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
                height: 100,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => showModal(),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? Text(
                                context
                                    .read<UserService>()
                                    .name
                                    .substring(0, 2)
                                    .toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 80),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(context.read<UserService>().name,
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
          Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: ElevatedButton(
              onPressed: () => _pressButton(),
              child: const Text("excluir conta"),
            ),
          ),
        ],
      ),
    );
  }
}
