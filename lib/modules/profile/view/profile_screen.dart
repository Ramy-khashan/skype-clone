import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skype/core/utils/functions/size_config.dart';
import 'package:skype/core/widget/app_button.dart';
import 'package:skype/core/widget/loading_item.dart';
import 'package:skype/modules/chats/model/user_model.dart';
import 'package:skype/modules/profile/controller/profile_cubit.dart';

import '../../../config/app_controller/appcontrorller_cubit.dart';
import '../../../core/repository/profile_repository/profile_repository_impl.dart';
import '../../../core/services/server_locator.dart';
import '../../../core/utils/app_color.dart';

class ProfileScreen extends StatelessWidget {
  final String tag;
  final UserModel userModel;
  const ProfileScreen({super.key, required this.tag, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileCubit(profileRepositoryImpl: sl.get<ProfileRepositoryImpl>())
            ..initial(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          ),
          title: Text(
            "Profile",
            style: TextStyle(
                color: Colors.white,
                fontSize: getFont(35),
                fontWeight: FontWeight.w900),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [AppColor.primary, AppColor.secondry])),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (_, state) {
            final controller = ProfileCubit.get(_);
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(getWidth(15)),
              child: Column(
                children: [
                  Hero(
                    tag: tag,
                    child: Stack(
                      children: [
                        controller.file == null
                            ? CircleAvatar(
                                foregroundImage: NetworkImage(userModel.image!),
                                radius: getWidth(80),
                              )
                            : CircleAvatar(
                                foregroundImage: FileImage(controller.file!),
                                radius: getWidth(80),
                              ),
                        Positioned(
                          bottom: 5,
                          right: 6,
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      AppColor.primary,
                                      AppColor.secondry
                                    ])),
                            child: IconButton(
                              onPressed: () {
                                controller.getImage();
                              },
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: getWidth(33),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: getHeight(15)),
                    child: Text(
                      userModel.name!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: getFont(36),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.email),
                      title: Text(userModel.email!),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.phone),
                      title: Text(userModel.phone!),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.privacy_tip),
                      title: const Text("User account private"),
                      trailing: Switch(
                          value: controller.isPrivate,
                          onChanged: (value) {
                            controller.changePrivateState(value);
                          }),
                    ),
                  ),
                  BlocBuilder<AppcontrorllerCubit, AppcontrorllerState>(
                    builder: (context, state) {
                      final appController = AppcontrorllerCubit.get(context);
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.dark_mode),
                          title: const Text("Dark Mode"),
                          trailing: Switch(
                              value: appController.isDark,
                              onChanged: (value) {
                                appController.changeTheme();
                              }),
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        controller.file == null
                            ? const SizedBox.shrink()
                            : AppButton(
                                head: "Save",
                                headSize: 22,
                                onPress: () async {
                                  await controller.saveNewProfileImage(context);
                                }),
                        const SizedBox(
                          height: 10,
                        ),
                        AppButton(
                            head: "Log out",
                            headSize: 22,
                            onPress: () async {
                              controller.logOut(context);
                            })
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
