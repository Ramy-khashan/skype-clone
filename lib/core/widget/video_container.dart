import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'loading_item.dart';
import 'package:video_player/video_player.dart';

class VideoContainerShape extends StatefulWidget {
  final String videoUrl;
  const VideoContainerShape({super.key, required this.videoUrl});

  @override
  State<VideoContainerShape> createState() => _VideoContainerShapeState();
}

class _VideoContainerShapeState extends State<VideoContainerShape> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  initial() async {
    videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    await videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
    );
    setState(() {});
  }

  @override
  void initState() {
    initial();
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,elevation: 0,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: chewieController == null
            ? const LoadingItem()
            : Chewie(
                controller: chewieController!,
              ),
      ),
    );
  }
}
