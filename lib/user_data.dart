import 'dart:io';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
class UserData{
  UserData({this.image});
  final File image;

}