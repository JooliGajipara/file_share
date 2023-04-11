import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  const VideoPlayerWidget({Key? key, required this.videoPath})
      : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        _controller!.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller!.value.isPlaying) {
          _controller!.pause();
          setState(() {});
        } else {
          _controller!.play();
          setState(() {});
        }
      },
      child: AspectRatio(
        aspectRatio: _controller!.value.aspectRatio,
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(_controller!),
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white30,
              child: _controller!.value.isPlaying
                  ? const Icon(
                      Icons.pause,
                      size: 25,
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.play_arrow,
                      size: 25,
                      color: Colors.black,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
