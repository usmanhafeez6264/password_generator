import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:password_generator/database_user.dart';
import 'package:password_generator/ulitlity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:password_generator/user_model.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'user_model.dart';
import 'database_user.dart';

class AddPass extends StatefulWidget {
  @override
  _AddPassState createState() => _AddPassState();
}

class _AddPassState extends State<AddPass> {
  Future<File> imageFile;
  Image image;
  DBHelper dbHelper;
  String id;
  List<UserModel> images;
  @override
  void initState() {
    super.initState();
    images = [];
    dbHelper = DBHelper();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final password = RandomPasswordGenerator();
  double passLen = 15;
  void generate() {
    newPassword = password.randomPassword(
        letters: _isWithLetters,
        numbers: _isWithNumbers,
        passwordLength: passLen,
        specialChar: _isWithSpecial,
        uppercase: _isWithUppercase);
    double passwordstrength = password.checkPassword(
      password: newPassword,
    );
  }

  bool _isWithLetters = true;
  bool _isWithUppercase = true;
  bool _isWithNumbers = true;
  bool _isWithSpecial = true;
  String newPassword = '';
  bool isButton = false;
  void changeButton() {
    setState(() {
      isButton = !isButton;
    });
  }

  var _image;
  final ImagePicker imagePicker = ImagePicker();
  Future imgFromGallery() async {
    try {
      ImagePicker.pickImage(source: ImageSource.gallery).then((imgFile) {
        String imgString = Utility.base64String(imgFile.readAsBytesSync());
        List<UserModel> photo = [
          UserModel(
              id: 1,
              img: imgString,
              title: titleController.text,
              category: "category",
              user: nameController.text,
              pass: newPassword)
        ];
        dbHelper.save(photo);
        // setState(() {
        //   images = photo;
        //   print(images);
        // });
      });
      setState(() {});
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[300],
                    child: IconButton(
                        color: Colors.grey,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close, color: Colors.red)),
                  ),
                  trailing: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[300],
                    child: IconButton(
                        color: Colors.grey,
                        onPressed: () {
                          imgFromGallery();
                        },
                        icon: Icon(Icons.done, color: Colors.green)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => imgFromGallery(),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.blue,
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50)),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.image,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 40,
                    child: Card(
                      color: Colors.grey[300],
                      child: Row(
                        children: [
                          SizedBox(
                            width: 2,
                          ),
                          isButton
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 02),
                                  child: ElevatedButton(
                                      child: Text(
                                        'Details',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      onPressed: () {
                                        changeButton();
                                        setState(() {});
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        primary: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 56, vertical: 04),
                                      )),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60),
                                  child: Text("Details",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),
                                ),
                          isButton
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 50),
                                  child: Text("Images",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),
                                )
                              : Padding(
                                  padding: EdgeInsets.symmetric(vertical: 02),
                                  child: ElevatedButton(
                                      child: Text(
                                        'Images',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      onPressed: () {
                                        changeButton();
                                        setState(() {});
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        primary: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 45, vertical: 04),
                                      )),
                                )
                        ],
                      ),
                    ),
                  ),
                ),
                !isButton
                    ? Card(
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(08.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: TextField(
                                  controller: titleController,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: "Title",
                                      hintStyle: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                      filled: true,
                                      border: InputBorder.none),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Card(
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Category",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 19)),
                                          Row(
                                            children: [
                                              Text("Personal",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 17)),
                                              Icon(Icons.arrow_forward_ios,
                                                  size: 15, color: Colors.grey),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Card(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.drag_indicator,
                                              color: Colors.blue),
                                          Text("Username"),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 9),
                                        child: TextField(
                                          controller: nameController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              prefixIcon: Icon(Icons.person,
                                                  color: Colors.grey),
                                              hintText: "username@example.com",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey)),
                                        )),
                                  ],
                                ),
                              ),
                              Card(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.drag_indicator,
                                              color: Colors.blue),
                                          Text("Password"),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 9),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, bottom: 05, top: 0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.vpn_key,
                                                  color: Colors.grey),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(newPassword,
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                              Spacer(),
                                              IconButton(
                                                  onPressed: () {
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text: newPassword));
                                                    setState(() {});
                                                  },
                                                  icon: Icon(Icons.copy,
                                                      color: Colors.green)),
                                              IconButton(
                                                  onPressed: () {
                                                    generate();
                                                    setState(() {});
                                                  },
                                                  icon: Icon(
                                                      Icons.casino_outlined,
                                                      color: Colors.blue))
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Text(images.isEmpty ? "EMoty" : images[0].category)
                // ListView.builder(
                //     shrinkWrap: true,
                //     itemCount: images.length,
                //     itemBuilder: (context, index) {
                //       return ListTile(
                //         leading: CircleAvatar(
                //           child: Image.memory(
                //               Base64Decoder().convert(images[index].img)),
                //         ),
                //         title: Text(images[index].title.toString()),
                //         subtitle: Text(images[index].user.toString()),
                //         trailing: Text(images[index].pass.toString(),
                //             style: TextStyle(color: Colors.blue)),
                //       );
                //     },
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
