enum MediaType { image, video }

abstract class ImageVideoState {}

class ShareInitial extends ImageVideoState {}

class ShareSelected extends ImageVideoState {
  final String? path;
  final MediaType? type;

  ShareSelected({this.path, this.type});
}

class ImageShared extends ShareSelected {
   ImageShared({required MediaType type, required String path})
      : super(type: type, path: path);
}