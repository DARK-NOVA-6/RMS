import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/presentation/controllers/personal_controllers.dart';
import 'profile_item_builder/profile_item_builder.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  late List<TextEditingController> phones;
  late List<String> genders;
  late String gender;
  late double rating;
  PersonalControllers personalControllers = PersonalControllers();

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
    phones = personalControllers.phones;
    genders = const ['Male', 'Female'];
    gender = 'Male';
    rating = 3.8;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          height: mq.size.height,
        ),
        child: Container(
          height: double.infinity,
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
              FirstNameBuilder(personalControllers: personalControllers),
              MiddleNameBuilder(personalControllers: personalControllers),
              LastNameBuilder(personalControllers: personalControllers),
              EmailBuilder(personalControllers: personalControllers),
              PhoneList(phones: phones, add: addPhone, remove: removePhone),
              GenderBuilder(genders: genders, gender: gender, chVal: chVal),
              FreeSpaceBuilder(personalControllers: personalControllers),
            ],
          ),
        ),
      ),
    );
  }
}

