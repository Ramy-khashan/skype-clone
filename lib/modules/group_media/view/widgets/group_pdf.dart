import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/utils/functions/open_url.dart';
 
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/functions/size_config.dart';
import '../../../../core/widget/loading_item.dart';

class GroupPdfItem extends StatelessWidget {
  final String groupId;

  const GroupPdfItem({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(AppString.firestorGroupKey)
            .doc(groupId)
            .collection(AppString.messafeKey)
            .where("type", isEqualTo: AppString.pdfType)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.docs.isEmpty
                ? Center(
                    child: Text(
                      "No PDF in group chat",
                      style: TextStyle(
                          fontSize: getFont(30), fontWeight: FontWeight.w500),
                    ),
                  )
                : GridView.count(
                    padding: const EdgeInsets.all(4),
                    crossAxisSpacing: 4,
                    crossAxisCount: 3,
                    children: List.generate(
                        snapshot.data!.docs.length,
                        (index) => GestureDetector(
                              onTap: () {},
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Card(
                                      child: ListTile(
                                    onTap: () async {
                                      await onOpenUrl(
                                          url: snapshot.data!.docs[index]
                                              .get("messages"));
                                    },
                                    leading: const FaIcon(
                                        FontAwesomeIcons.circlePlay),
                                    title: Text(
                                        snapshot.data!.docs[index].get("name") +
                                            " sent this PDF"),
                                    subtitle: Text(snapshot.data!.docs[index]
                                        .get("description")),
                                  ))),
                            )));
          } else {
            return const LoadingItem();
          }
        });
  }
}
