import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
 
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/functions/size_config.dart';
import '../../../../core/widget/loading_item.dart';
import '../../controller/group_manager_cubit.dart';

class MemberShape extends StatelessWidget {
  final String groupId;
  final String userId;
  final String member;
  final List admin;
  final int index;
  // List.from( snapshot.data!.get("members"))[index]
  const MemberShape(
      {super.key,
      required this.groupId,
      required this.member,
      required this.index,
      required this.userId,
      required this.admin});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(AppString.firestorUsereKey)
            .doc(member)
            .snapshots(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            return Card(
              color: Colors.primaries[index % Colors.primaries.length]
                  .withOpacity(.5),
              child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(userSnapshot.data!.get("image")),
                    radius: getWidth(25),
                  ),
                  title: Text(
                    userSnapshot.data!.get("name"),
                    style: TextStyle(
                        fontSize: getFont(25), fontWeight: FontWeight.w500),
                  ),
                  subtitle: admin.contains(userSnapshot.data!.get("user_id"))
                      ? const Text("Admin")
                      : null,
                  trailing: admin.contains(userId)
                      ? admin.contains(userSnapshot.data!.get("user_id"))
                          ? userSnapshot.data!.get("user_id") == userId
                              ? IconButton(
                                  onPressed: () async {
                                    await GroupManagerCubit.get(context)
                                        .deleteUser(
                                            context: context,
                                            groupId: groupId,
                                            userId: userSnapshot.data!
                                                .get("user_id"));
                                  },
                                  icon: const Icon(
                                    Icons.login_rounded,
                                    color: Colors.white,
                                  ))
                              : const SizedBox()
                          : PopupMenuButton(
                              icon: Icon(
                                Icons.adaptive.more,
                                color: Colors.white,
                              ),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: const Text("Set As Admin"),
                                  onTap: () {
                                    GroupManagerCubit.get(context).setAdmin(
                                        groupId: groupId,
                                        userId:
                                            userSnapshot.data!.get("user_id"));
                                  },
                                ),
                                PopupMenuItem(
                                  child: const Row(
                                    children: [
                                      Text(" Delete"),
                                    ],
                                  ),
                                  onTap: () async {
                                    await GroupManagerCubit.get(context)
                                        .deleteUser(
                                            context: context,
                                            groupId: groupId,
                                            userId: userSnapshot.data!
                                                .get("user_id"));
                                  },
                                ),
                              ],
                            )
                      : userId == userSnapshot.data!.get("user_id")
                          ? IconButton(
                              onPressed: () async {
                                await GroupManagerCubit.get(context).deleteUser(
                                    context: context,
                                    groupId: groupId,
                                    userId: userId);
                              },
                              icon: const Icon(Icons.login_rounded))
                          : const SizedBox()),
            );
          } else {
            return const LoadingItem();
          }
        });
  }
}
