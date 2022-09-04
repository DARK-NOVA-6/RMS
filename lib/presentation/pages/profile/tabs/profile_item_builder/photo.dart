import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/update_action_bar_actions_notification.dart';

class Photo extends StatelessWidget {
  const Photo({
    Key? key,
    required this.image,
    required this.pickImage,
  }) : super(key: key);

  final File? image;
  final Function() pickImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          SizedBox(
            height: 220,
            width: 220,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: (image == null)
                  ? const Text(
                      'No Image',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    )
                  : ClipOval(
                      child: Image.file(
                        image!,
                        height: 210,
                        width: 210,
                        fit: BoxFit.fill,
                      ),
                    ),
            ),
          ),
          if (Provider.of<UpdateActionBarActions>(context).edit) ...[
            Positioned(
              right: 10,
              bottom: 10,
              child: CircleAvatar(
                maxRadius: 25,
                backgroundColor: Colors.white,
                child: IconButton(
                  padding: const EdgeInsets.only(
                    bottom: 0.5,
                    right: 0.5,
                  ),
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                    size: 35,
                  ),
                  onPressed: pickImage,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
