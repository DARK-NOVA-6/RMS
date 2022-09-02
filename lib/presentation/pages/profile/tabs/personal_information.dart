import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/presentation/controllers/personal_controllers.dart';
import '../../../../domain/usecases/user/get_profile_user.dart';
import '../../../controllers/user_controller.dart';
import 'profile_item_builder/profile_item_builder.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({
    Key? key,
    required this.personalControllers,
  }) : super(key: key);
  final PersonalControllers personalControllers;

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  late List<TextEditingController> phones;
  late List<String> genders;
  late String gender;
  late double rating;

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }

  addPhone() {
    setState(() {
      phones.insert(phones.length, TextEditingController());
    });
  }

  removePhone(index) {
    setState(() {
      phones.removeAt(index);
    });
  }

  chVal(value) {
    setState(() {
      gender = value;
    });
  }

  @override
  void initState() {
    super.initState();
    phones = widget.personalControllers.phones;
    genders = const ['Male', 'Female'];
    gender = 'Male';
    rating = 3.8;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1,
            ),
          ),
        ),
        child: ListView(
          primary: false,
          shrinkWrap: true,
          children: [
            const SizedBox(height: 15),
            Photo(
              image: image,
              pickImage: pickImage,
            ),
            const SizedBox(height: 15),
            Rating(rating: rating),
            const SizedBox(height: 15),
            FirstNameBuilder(personalControllers: widget.personalControllers),
            MiddleNameBuilder(
                personalControllers: widget.personalControllers),
            LastNameBuilder(personalControllers: widget.personalControllers),
            EmailBuilder(personalControllers: widget.personalControllers),
            PhoneList(phones: phones, add: addPhone, remove: removePhone),
            GenderBuilder(genders: genders, gender: gender, chVal: chVal),
            FreeSpaceBuilder(personalControllers: widget.personalControllers),
          ],
        ),
      ),
    );
  }
}
