import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:skype/core/utils/functions/create_group.dart';
import 'package:skype/core/widget/app_button.dart';
import 'package:skype/modules/group_chat/view/group_chat.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/functions/size_config.dart';
import '../../../core/widget/loading_item.dart';
import '../controller/group_cubit.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController sheetController;
  @override
  void initState() {
    sheetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    sheetController.animateTo(0);
    super.initState();
  }

  @override
  void dispose() {
    sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCubit, GroupState>(builder: (context, state) {
      final controller = GroupCubit.get(context);
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            createGroupModelSheet(
                context: context,
                sheetController: sheetController,
                controller: controller);
            // //TODO Create Group Ui
            // await controller.createGroup();
            // await controller.getGroups();
          },
          icon: const FaIcon(FontAwesomeIcons.plus),
          label: Text(
            "Group",
            style: TextStyle(fontSize: getFont(22)),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.getUserdata();
            controller.getFrinds();
            controller.getGroups();
          },
          child: controller.isLoadingGroup
              ? const LoadingItem()
              : controller.userGroup.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Text(
                            "This Quite For Now\nNo Group Exsist",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: getFont(30), color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppButton(
                                  head: "Create Group",
                                  headSize: 22,
                                  onPress: () async {
                                    createGroupModelSheet(
                                        context: context,
                                        sheetController: sheetController,
                                        controller: controller);
                                  }),
                              const SizedBox(
                                width: 10,
                              ),
                              FloatingActionButton(
                                elevation: 10,
                                onPressed: () {
                                  controller.getUserdata();
                                  controller.getFrinds();
                                  controller.getGroups();
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35)),
                                child: const Icon(
                                  Icons.refresh,
                                  size: 30,
                                ),
                              )
                            ],
                          )
                        ])
                  : ListView.builder(
                      itemCount: controller.userGroup.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection(AppString.firestorGroupKey)
                                  .doc(controller.userGroup[index].groupId)
                                  .collection(AppString.messafeKey)
                                  .orderBy("time")
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return snapshot.data!.docs.isEmpty
                                      ? const SizedBox()
                                      : ListTile(
                                          leading: Hero(
                                            tag: controller
                                                    .userGroup[index].image
                                                    .toString() +
                                                index.toString(),
                                            child: CircleAvatar(
                                              backgroundColor: AppColor.primary,
                                              foregroundImage: NetworkImage(
                                                  controller
                                                      .userGroup[index].image),
                                            ),
                                          ),
                                          title: Text(
                                              controller.userGroup[index].name),
                                          subtitle: snapshot.data!.docs.last
                                                          .get("messages").toString().isEmpty?Text("Group Created by ${ snapshot.data!.docs.last
                                                          .get("name")} "): snapshot.data!.docs.last
                                                      .get("type") ==
                                                  "image"
                                              ? Text(((snapshot.data!.docs.last
                                                          .get("sender")) ==
                                                      controller
                                                          .userModel!.userid!
                                                  ? "you : sent image"
                                                  : "${controller.userFriendData[index].name!.split(" ")[0]} sent image"))
                                              : snapshot.data!.docs.last
                                                          .get("messages") ==
                                                      AppString.likeKey
                                                  ? Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(((snapshot.data!
                                                                      .docs.last
                                                                      .get(
                                                                          "sender")) ==
                                                                  controller
                                                                      .userModel!
                                                                      .userid!
                                                              ? "you : "
                                                              : "")),
                                                          Image.asset(
                                                            AppAssets.like,
                                                            width: getWidth(35),
                                                            height:
                                                                getHeight(35),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Text(
                                                      ((snapshot.data!.docs.last
                                                                      .get(
                                                                          "sender")) ==
                                                                  controller
                                                                      .userModel!
                                                                      .userid!
                                                              ? "you : "
                                                              : "") +
                                                          snapshot
                                                              .data!.docs.last
                                                              .get("messages")
                                                              .toString(),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      GroupChatScreen(
                                                    tag: controller
                                                            .userGroup[index]
                                                            .image
                                                            .toString() +
                                                        index.toString(),
                                                    groupData: controller
                                                        .userGroup[index],
                                                    userId: controller
                                                        .userModel!.userid!,
                                                  ),
                                                ));
                                          },
                                          trailing: Text(DateFormat.jm().format(
                                              (snapshot.data!.docs.last
                                                      .get("time") as Timestamp)
                                                  .toDate())),
                                        );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }),
                        );
                      },
                    ),
        ),
      );
    });
  }
}
