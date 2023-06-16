import 'package:equatable/equatable.dart';

class PhotosUploadResponse extends Equatable {
  final String? data;
  final String? message;
  final bool? success;

  const PhotosUploadResponse({this.data, this.message, this.success});

  @override
  List<Object?> get props => [data, message, success];
}
