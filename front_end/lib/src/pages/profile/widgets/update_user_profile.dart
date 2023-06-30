import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:getgoods/src/common_widgets/loading_dialog.dart';
import 'package:getgoods/src/common_widgets/shadow_container.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:getgoods/src/viewmodels/user_viewmodel.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateImageProfilePage extends StatefulWidget {
  const UpdateImageProfilePage({super.key});

  @override
  State<UpdateImageProfilePage> createState() => _UpdateImageProfilePageState();
}

class _UpdateImageProfilePageState extends State<UpdateImageProfilePage> {
  Future<void> _getImageFromGallery() async {
    loadingDialog(context);
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  final UserViewModel _userViewModel = UserViewModel();

  String _imagePath = '';

  Future<void> _uploadImage(File imageFile) async {
    loadingDialog(context);
    final String? token = await _getToken();
    var request = http.MultipartRequest(
      'PATCH',
      Uri.parse(
        '${ApiConstants.baseUrl}//users/updateMe',
      ),
    );
    request.headers['Authorization'] = 'Bearer $token';

    request.files.add(await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
      contentType: MediaType('image', 'jpeg'),
    ));

    var response = await request.send();
    log(response.statusCode.toString());
    // log(response.data.toString());
    log(response.request.toString());
    log(response.stream.toString());

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      const Dialog(
        child: Text('Image uploaded successfully'),
      );
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      const Dialog(
        child: Text('Image upload failed'),
      );
      print('Image upload failed with status code ${response.statusCode}');
    }
  }

  Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Image Profile'),
        ),
        body: Column(
          children: [
            ShadowContainer(
              items: [
                _buildRichText('Image Cover', 1),
                const SizedBox(height: 10),
                const Text(
                  'The image cover will be used as the main product image for display in a size of 600x600 pixels.',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (_imagePath != '')
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Image.file(
                                  File(_imagePath),
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 1.5,
                                spreadRadius: 0.1,
                              )
                            ],
                          ),
                          child: Image.file(
                            File(_imagePath),
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    // SizedBox(width: 12,
                    //     _imagePath == '' ? 0 : 12,
                    //     ),
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: grey,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: grey,
                        ),
                        onPressed: () {
                          _getImageFromGallery();
                        },
                        child: Text(
                          'Image',
                          semanticsLabel: _imagePath == ''
                              ? 'Upload Image'
                              : 'Change Image',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton(
                onPressed: () {
                  log('uploading image');
                  _uploadImage(
                    File(_imagePath),
                  );
                },
                child: const Text('Update Image'),
              ),
            ),
          ],
        ));
  }

  RichText _buildRichText(String label, int totalLength) {
    return RichText(
      text: TextSpan(
        text: '$label ',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
        ),
        children: [
          totalLength != 0
              ? TextSpan(
                  text: '(0/$totalLength)',
                  style: const TextStyle(
                    color: secondaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                )
              : const TextSpan(),
          const TextSpan(
            text: '*',
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }
}
