// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use
import 'dart:io';
import 'package:file_share/bloc/image_video_bloc/image_video_state.dart';
import 'package:file_share/ui/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/image_video_bloc/image_video_bloc.dart';
import '../bloc/image_video_bloc/image_video_event.dart';

class ImageVideoPickerScreen extends StatefulWidget {
  const ImageVideoPickerScreen({Key? key}) : super(key: key);

  @override
  State<ImageVideoPickerScreen> createState() => _ImageVideoPickerScreenState();
}

class _ImageVideoPickerScreenState extends State<ImageVideoPickerScreen> {
  final _bloc = ShareBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Image/Video'),
        centerTitle: true,
      ),
      body: BlocBuilder<ShareBloc, ImageVideoState>(
        bloc: _bloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Column(
              children: <Widget>[
                if (state is ShareSelected)
                  Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: state.type == MediaType.image
                        ? Image.file(
                            File(state.path.toString()),
                            filterQuality: FilterQuality.high,
                          )
                        : VideoPlayerWidget(videoPath: state.path.toString()),
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state is ShareSelected)
                      RaisedButton(
                        color: Colors.blueGrey,
                        child: const Text('Share'),
                        onPressed: () {
                          _bloc.add(ShareMedia());
                        },
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.blueGrey,
                          onPressed: () {
                            _bloc.add(SelectImage());
                          },
                          child: const Text('Select Image'),
                        ),
                        RaisedButton(
                          color: Colors.blueGrey,
                          child: const Text('Select Video'),
                          onPressed: () {
                            _bloc.add(ClearMedia());
                            _bloc.add(SelectVideo());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
