import 'package:image_picker/image_picker.dart';

class PhotoUploadingCardModel {
  String title;
  String? photoUrl;
  List<XFile?> images = [];

  PhotoUploadingCardModel({
    required this.title,
    this.photoUrl,
    required this.images,
  });
}
