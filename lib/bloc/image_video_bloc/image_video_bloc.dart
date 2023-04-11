import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import 'image_video_event.dart';
import 'image_video_state.dart';

class ShareBloc extends Bloc<ImageVideoEvent, ImageVideoState> {
  String _path = '';

  ShareBloc() : super(ShareInitial()) {
    on<SelectImage>((event, emit) async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _path = pickedFile.path;
        emit(ShareSelected(path: _path, type: MediaType.image));
      }
    });

    on<SelectVideo>((event, emit) async {
      final picker = ImagePicker();
      final pickedVFile = await picker.pickVideo(source: ImageSource.gallery);
      if (pickedVFile != null) {
        _path = pickedVFile.path;
        final controller = VideoPlayerController.file(File(_path));
        await controller.initialize();
        emit(ShareSelected(path: _path, type: MediaType.video));
      }
    });

    on<ClearMedia>((event, emit) {
      emit(ShareInitial());
    });

    on<ShareMedia>((event, emit) async {
      final file = File(_path);
      await Share.shareFiles([file.path]);
      emit(ImageShared(
        type: (state as ShareSelected).type!,
        path: (state as ShareSelected).path!,
      ));
    });
  }
}
