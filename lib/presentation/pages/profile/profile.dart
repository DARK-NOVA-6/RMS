import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:untitled/data/datasources/remote/cv_parser_api.dart';
import 'package:untitled/domain/usecases/authentication/get_connected_user.dart';
import 'package:untitled/domain/usecases/user/update_profile_user.dart';
import 'package:untitled/domain/usecases/user/upload_cv.dart';
import 'package:untitled/injection_container.dart';
import 'package:untitled/presentation/controllers/controllers.dart';
import 'package:untitled/presentation/pages/profile/profile_navigator.dart';
import 'package:untitled/provider/update_action_bar_actions_notification.dart';

import '../../../domain/entities/user/user_info.dart';
import '../../components/components.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int currentIndex = 0;
  String currentPage = 'personal';
  late bool isLoading;
  UserController userController =
      TransformerUserController.fromUserInfo(GetConnectedUser().connectedUser);
  List<String> pagesKeys = ['personal', 'edu', 'exp', 'skills', 'lang'];
  Map<String, GlobalKey<NavigatorState>> navigatorState = {
    'personal': GlobalKey<NavigatorState>(),
    'edu': GlobalKey<NavigatorState>(),
    'exp': GlobalKey<NavigatorState>(),
    'skills': GlobalKey<NavigatorState>(),
    'lang': GlobalKey<NavigatorState>(),
  };
  final List<Text> texts = [
    const Text('Personal Information', style: TextStyle(fontSize: 20)),
    const Text(
      'Educational Qualifications',
      style: TextStyle(fontSize: 20),
    ),
    const Text('Past Experience', style: TextStyle(fontSize: 20)),
    const Text('Skills', style: TextStyle(fontSize: 20)),
    const Text('Languages', style: TextStyle(fontSize: 20)),
  ];
  late List<Widget> actions1;
  late List<Widget> actions2;
  UpdateProfileUser updateProfileUser = UpdateProfileUser();

  saveChanges() async {
    setState(() {
      isLoading = true;
    });
    UserInfo userInfo =
        TransformerUserController.fromUserController(userController);

    UserController? newUserController;
    await updateProfileUser(newUserInfo: userInfo).then((value) {
      newUserController = TransformerUserController.fromUserInfo(
          GetConnectedUser().connectedUser);
    });

    setState(() {
      if(newUserController != null) {
        userController = newUserController!;
      }
      isLoading = false;
    });

    // ignore: use_build_context_synchronously
    Provider.of<UpdateActionBarActions>(context, listen: false)
        .changeEditMode(false);
  }

  @override
  void initState() {
    super.initState();
    isLoading = false;
    actions2 = [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          icon: const Icon(
            Icons.edit,
            size: 30,
          ),
          onPressed: () {
            Provider.of<UpdateActionBarActions>(context, listen: false)
                .changeEditMode(true);
          },
        ),
      ),
    ];
    actions1 = [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          icon: const Icon(
            Icons.published_with_changes_outlined,
            size: 30,
          ),
          onPressed: saveChanges,
        ),
      ),
    ];
  }

  void selectTab(int index) {
    if (currentPage == pagesKeys[index]) {
      navigatorState[index]?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentPage = pagesKeys[index];
        currentIndex = index;
      });
    }
  }

  Future<File> saveFileLocal(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
    return File(file.path!).copy(newFile.path);
  }

  Future showToast(String msg) async {
    await Fluttertoast.cancel();
    Fluttertoast.showToast(msg: msg, fontSize: 18);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DefaultTabController(
        initialIndex: currentIndex,
        length: pagesKeys.length,
        child: WillPopScope(
          onWillPop: () async {
            final isFirstRouteInCurrentTab =
                !await navigatorState[currentPage]!.currentState!.maybePop();
            if (isFirstRouteInCurrentTab) {
              if (currentPage != 'personal') {
                selectTab(1);
              }
            }
            return isFirstRouteInCurrentTab;
          },
          child: Scaffold(
            floatingActionButton: SpeedDial(
              backgroundColor: Theme.of(context).primaryColor,
              spacing: 20,
              childPadding: const EdgeInsets.symmetric(vertical: 10),
              buttonSize: const Size.square(70),
              childrenButtonSize: const Size.square(70),
              children: [
                SpeedDialChild(
                    child: const Icon(Icons.download),
                    onTap: () {},
                    label: 'Download an existing CV',
                    labelStyle: const TextStyle(
                      fontSize: 20,
                    )),
                SpeedDialChild(
                  child: const Icon(Icons.add),
                  onTap: () async {
                    final result = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                    );
                    if (result == null) return;
                    final file = result.files.first;
                    showToast('File Uploaded Successfully');
                    // print('Name :${file.name}');
                    // print('Path :${file.path}');
                    // print('Size :${file.size}');
                    // print('Extension :${file.extension}');
                    final File newFile = await saveFileLocal(file);
                    await UploadCv(
                        cvParserApi: CvParserApiImp(),
                        authenticationRepo: sl())(cvPdf: newFile);
                    // print('From: ${file.path}');
                    // print('To: ${newFile.path}');
                    showToast('File Saved Successfully');
                  },
                  label: 'Add a CV',
                  labelStyle: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
              child: const Text(
                'CV',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            appBar: CustomeAppBar(
              label: 'Profile',
              actions1: actions1,
              actions2: actions2,
            ),
            body: Scaffold(
              appBar: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                isScrollable: true,
                // padding: const EdgeInsets.only(top: 10),
                onTap: (value) => selectTab(value),
                tabs: texts,
              ),
              body: (isLoading)
                  ? Center(
                      child: SpinKitFoldingCube(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : Stack(
                      children: pagesKeys
                          .map(
                            (e) => buildOffstageNavigator(e),
                          )
                          .toList(),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: currentPage != tabItem,
      child: ProfileNavigator(
        userController: userController,
        navigatorState: navigatorState[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
