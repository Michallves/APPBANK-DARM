import 'dart:io';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AccountUser extends StatefulWidget {
  const AccountUser({super.key});

  @override
  State<AccountUser> createState() => _AccountUserState();
}

class _AccountUserState extends State<AccountUser> {
  bool isButtonActive = false;

  void pressButton() {
    Navigator.of(context).pushNamed(AppRoutes.HOME);
  }

  File? _image;

  Future<File?> _pickImage() async {
    final picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage != null) return null;
  }

  void showBottomSheet() => showModalBottomSheet(
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
                const Divider(height: 1),
                ListTile(
                  iconColor: Colors.black,
                  title: const Text('Camera'),
                  leading: const Icon(Icons.camera_alt),
                  onTap: _pickImage,
                ),
                const ListTile(
                  iconColor: Colors.black,
                  title: Text('Galeria'),
                  leading: Icon(Icons.image),
                  onTap: null,
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
                      onTap: () => showBottomSheet(),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child: const Text(
                          'MA',
                          style: TextStyle(color: Colors.white, fontSize: 80),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text('Michael Alves Pereira',
                        style: TextStyle(fontSize: 25))
                  ],
                )),
          ),
          Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: ElevatedButton(
              onPressed: () => pressButton(),
              child: const Text("alterar senha"),
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: ElevatedButton(
              onPressed: () => pressButton(),
              child: const Text("excluir conta"),
            ),
          ),
        ],
      ),
    );
  }
}
