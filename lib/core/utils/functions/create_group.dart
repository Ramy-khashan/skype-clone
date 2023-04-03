import 'package:flutter/material.dart';

import 'package:skype/core/utils/app_color.dart';
import 'package:skype/core/utils/functions/app_toast.dart';
import 'package:skype/core/utils/functions/size_config.dart';
import 'package:skype/core/widget/app_button.dart';

import '../../../modules/group/controller/group_cubit.dart';
import '../../widget/loading_item.dart';
import 'bottom_sheet_head.dart';

createGroupModelSheet(
    {required BuildContext context,
    sheetController,
    required GroupCubit controller}) {
  return showModalBottomSheet(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    transitionAnimationController: sheetController,
    enableDrag: true,
    context: context,
    isDismissible: !controller.isLodingGroupData,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Form(
            key: controller.formKey,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      controller.isNextStepGroup
                          ? GestureDetector(
                              onTap: () {
                                controller.isNextStepGroup = false;
                                setState(() {});
                              },
                              child: const Icon(Icons.arrow_back))
                          : const SizedBox(),
                      Expanded(
                        child: BottomSheetHead(
                          head: controller.isNextStepGroup
                              ? "Enter Group Info"
                              : "Choose Group Member",
                        ),
                      ),
                    ],
                  ),
                  controller.isNextStepGroup
                      ? Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter group name";
                                    }
                                    return null;
                                  },
                                  controller: controller.groupNameController,
                                  decoration: InputDecoration(
                                    hintText: "Group Name",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: AppColor.primary, width: 1),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: getHeight(15)),
                                  child: Text("Group Image",
                                      style: TextStyle(
                                          fontSize: getFont(22),
                                          fontWeight: FontWeight.w600)),
                                ),
                                InkWell(
                                  onTap: () async {
                                    // controller.getImage
                                  },
                                  child: Container(
                                    width: getWidth(120),
                                    height: getHeight(150),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Theme.of(context)
                                                    .brightness
                                                    .index ==
                                                1
                                            ? Colors.white
                                            : Colors.grey.shade900,
                                        boxShadow: const [
                                          BoxShadow(
                                              spreadRadius: 5,
                                              blurRadius: 4,
                                              color: Colors.grey)
                                        ]),
                                    child: controller.imageFile == null
                                        ? const Center(
                                            child: Icon(Icons.add_a_photo),
                                          )
                                        : Image.file(controller.imageFile!),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : controller.userFriendData.isEmpty
                          ? Expanded(
                              child: Center(
                                  child: Text(
                              "You have no Frinds to create group",
                              style: TextStyle(
                                  fontSize: getFont(25),
                                  fontWeight: FontWeight.w600),
                            )))
                          : Expanded(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(controller
                                        .userFriendData[index].image!),
                                  ),
                                  title: Text(
                                      controller.userFriendData[index].name!),
                                  trailing: Checkbox(
                                    value: controller.groupSelectedIdList
                                        .contains(controller
                                            .userFriendData[index].userid),
                                    onChanged: (value) {
                                      controller.addToSelected(
                                          id: (controller
                                              .userFriendData[index].userid)!,
                                          isCheck: value!);
                                      setState(() {});
                                    },
                                  ),
                                ),
                                itemCount: controller.userFriendData.length,
                              ),
                            ),
                  controller.userFriendData.isEmpty
                      ? const SizedBox()
                      : Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: getWidth(12)),
                          child: controller.isLodingGroupData
                              ? const LoadingItem()
                              : AppButton(
                                  headSize: getFont(25),
                                  head: controller.isNextStepGroup
                                      ? "Create"
                                      : "Next",
                                  onPress: controller.isNextStepGroup
                                      ? () async {
                                          if (controller.formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              controller.isLodingGroupData =
                                                  true;
                                            });
                                            await controller.createGroup(
                                                context: context);

                                            setState(() {
                                              controller.isLodingGroupData =
                                                  false;
                                            });
                                          }
                                        }
                                      : () {
                                          if (controller
                                                  .groupSelectedIdList.length >
                                              1) {
                                            setState(() {
                                              controller.isNextStepGroup = true;
                                            });
                                          } else {
                                            appToast(
                                                "Chosse Frinds To Create Group");
                                          }
                                        },
                                ),
                        ),
                  SizedBox(
                    height: getHeight(10),
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
