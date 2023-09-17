 

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/functions/size_config.dart';
import '../../../core/widget/loading_item.dart';
import '../../group/model/group_model.dart';
import 'widgets/group_media_shape.dart';
import 'widgets/member_shape.dart'; 
import '../../../core/utils/app_color.dart';
import '../controller/group_manager_cubit.dart';

class GroupManagerScreen extends StatelessWidget {
  final String groupId;
  final GroupModel groupModel;
  final String userId;
  const GroupManagerScreen({
    super.key,
    required this.groupId,
    required this.userId,
    required this.groupModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupManagerCubit(),
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const FaIcon(FontAwesomeIcons.arrowLeft),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [AppColor.primary, AppColor.secondry])),
            ),
            centerTitle: true,
            title: Text(
              "Group Manager",
              style: TextStyle(
                  fontSize: getFont(30),
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            )),
        body: BlocBuilder<GroupManagerCubit, GroupManagerState>(
          builder: (context, state) {
            
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(AppString.firestorGroupKey)
                    .doc(groupId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: CircleAvatar(
                                foregroundImage:
                                    NetworkImage(snapshot.data!.get("image")),
                                radius: getWidth(70),
                              ),
                            ),
                            SizedBox(
                              height: getHeight(10),
                            ),
                            Center(
                                child: Text(
                              snapshot.data!.get("name"),
                              style: TextStyle(
                                  fontSize: getFont(26),
                                  fontWeight: FontWeight.w700),
                            )),
                            GroupMediaShape(groupId: groupId),
                            Text(
                              "Group member",
                              style: TextStyle(
                                fontSize: getFont(23),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Divider(),
                            ListView.builder(
                                itemCount:
                                    List.from(snapshot.data!.get("members"))
                                        .length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) => MemberShape(
                                    groupId: groupId,
                                    member: List.from(
                                        snapshot.data!.get("members"))[index],
                                    index: index,
                                    userId: userId,
                                    admin:
                                        List.from(snapshot.data!.get("admin"))))
                          ],
                        ));
                  } else {
                    return const LoadingItem();
                  }
                });
          },
        ),
      ),
    );
  }
}
