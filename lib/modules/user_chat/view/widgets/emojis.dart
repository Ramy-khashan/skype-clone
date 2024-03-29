import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
class EmojisScreen extends StatelessWidget {
  final bool isEmoji;
  final Function onChange;
  final TextEditingController messageController;
  const EmojisScreen({super.key, required this.isEmoji, required this.messageController, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage:!  isEmoji,
      child: SizedBox(
          height: 250,
          child: EmojiPicker(
            textEditingController: messageController,
            onEmojiSelected: (category, emoji) {
              onChange();
              },
            config: Config(
              columns: 7,
              // Issue: https://github.com/flutter/flutter/issues/28894
              emojiSizeMax: 32 *
                  (foundation.defaultTargetPlatform == TargetPlatform.iOS
                      ? 1.30
                      : 1.0),
              verticalSpacing: 0,
              horizontalSpacing: 0,
              gridPadding: EdgeInsets.zero,
              initCategory: Category.RECENT,
              bgColor: const Color(0xFFF2F2F2),
              indicatorColor: Colors.blue,
              iconColor: Colors.grey,
              iconColorSelected: Colors.blue,
              backspaceColor: Colors.blue,
              skinToneDialogBgColor: Colors.white,
              skinToneIndicatorColor: Colors.grey,
              enableSkinTones: true,
             

              recentsLimit: 28,
              replaceEmojiOnLimitExceed: false,
              noRecents: const Text(
                'No Recents',
                style: TextStyle(fontSize: 20, color: Colors.black26),
                textAlign: TextAlign.center,
              ),
              loadingIndicator: const SizedBox.shrink(),
              tabIndicatorAnimDuration: kTabScrollDuration,
              categoryIcons: const CategoryIcons(),
              buttonMode: ButtonMode.MATERIAL,
              checkPlatformCompatibility: true,
            ),
          )),
    );
  }
}
