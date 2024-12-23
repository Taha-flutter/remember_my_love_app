import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';

import '../../controllers/VideoPlayerScreenController.dart';

class VideoPlayerScreen extends GetView<VideoPlayerScreenController> {
  static const routeName = "VideoPlayerScreen";

  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String videoUrl = Get.arguments as String;
    controller.initializeVideo(videoUrl);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.7),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Get.back(); // Close the full-screen player
          },
        ),
      ),
      body: Center(
        child: Obx(() {
          // Check if the video is initialized
          if (controller.isInitialized.value) {
            return Chewie(
              controller: controller.chewieController,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
