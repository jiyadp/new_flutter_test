import 'package:equatable/equatable.dart';

class PhotosGalleryParams extends Equatable {
  final List<String?>? images;
  final int? position;

  const PhotosGalleryParams({this.images, this.position});

  @override
  List<Object?> get props => [images, position];
}
