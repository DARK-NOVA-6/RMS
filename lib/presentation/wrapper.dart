import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled/core/utils/custom_converter.dart';

import '../core/utils/custom_converter.dart';
import '../core/utils/detect_uri_api.dart';
import '../provider/theme.dart';
import '../provider/theme_notifier.dart';
import 'blocs/authentication/auth_bloc.dart';
import 'controllers/controllers.dart';
import 'splash_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({
    Key? key,
    required this.authBloc,
    required this.controllers,
  }) : super(key: key);

  final AuthBloc authBloc;
  final Controllers controllers;

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String? selected;
  Widget? toRender;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String? selected;

    var splash = SplashScreen(controllers: widget.controllers);
    var dropdown = Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('uri-api').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('check internet connection!');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('please wait.');
            }
            var listTemp = snapshot.data!.docs[0];
            List<String> list =
                CustomConverter().toListString(list: listTemp['list']);
            print(list);
            return Material(
              child: DropdownButton(
                value: selected,
                items: list
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (String? newVal) {
                  setState(() {
                    selected = newVal;
                  });
                },
              ),
            );
          },
        ),
        ElevatedButton(
          onPressed: () {
            if (selected != null) {
              DetectUriApi.uriApi = selected!;
              setState(() {
                toRender = splash;
              });
            }
          },
          child: Text(selected ?? 'please select URI'),
        ),
      ],
    );
    toRender = dropdown;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.authBloc,
      child: ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier themeNotifier, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'RMS Demo pla....',
              theme: themeNotifier.darkTheme
                  ? CustomeTheme.dark
                  : CustomeTheme.light,
              home: toRender,
            );
          },
        ),
      ),
    );
  }
}
