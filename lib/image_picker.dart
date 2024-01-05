import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final imagePicker = ImagePicker();
  XFile? _image;
  List<File> ? _pickedFiles;
  PlatformFile? _platformFile;

  Future<void> _pickImageFromGallery() async {
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = XFile(pickedImage.path);
      }
    });
  }

  Future<void> _pickImageFromCamera() async {
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        _image = XFile(pickedImage.path);
      }
    });
  }

  Future<void> _showImagePickingOption(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoButton(
                    child: const Text("Pick Image from Gallery"),
                    onPressed: () {
                      _pickImageFromGallery();
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoButton(
                    child: const Text("Pick Image from Camera"),
                    onPressed: () {
                      _pickImageFromCamera();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      _platformFile = result.files.first;
      _pickedFiles = result.paths.map((path) => File(path!)).toList();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final kb = _platformFile?.size ?? 1 / (1024);
    final mb = kb / 1024;
    final size = mb > 1
        ? "${mb.toStringAsFixed(2)}\nmb"
        : "${kb.toStringAsFixed(2)}\nkb";
    // print("Size" + kb.toString());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                if (_image != null)
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey,
                    child: Image.file(
                      File(_image!.path),
                      height: 200,
                      width: 200,
                      fit: BoxFit.fill,
                    ),
                  ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if(_pickedFiles!=null)
              Expanded(
                child: ListView.builder(
                itemCount: _pickedFiles?.length,
                  itemBuilder: (context, index) {
                  return Column(
                    children: [
                      if (_platformFile != null)
                        ListTile(
                          tileColor: Colors.green,
                          //  selectedTileColor: Colors.blue,
                          title: Text(
                            _platformFile!.name,
                          ),
                          //  subtitle:  Text(_platformFile!.extension! ) ,
                          leading: CircleAvatar(
                            radius: 30,
                            child: Text(
                              "$size\nkb",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          trailing: Text(
                            _platformFile!.extension!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ) ;
                },),
              )

           ,
            ElevatedButton(
              onPressed: () {
                _showImagePickingOption(context);
              },
              child: const Text(
                "Pick Image",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _pickFiles();
              },
              child: const Text(
                "Pick File",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
