import 'package:eminencetel/features/data/models/photos_model.dart';
import 'package:equatable/equatable.dart';

class PhotosResponse extends Equatable {
  List<CategoriesData>? data;
  String? message;
  bool? success;

  PhotosResponse({this.data, this.message, this.success});

  @override
  List<Object?> get props => [data, message, success];
}

class CategoriesResponse extends Equatable {
  String? id;
  String? categoryTitle;
  String? userId;
  String? scheduleId;
  String? groupId;
  String? formId;
  String? formNo;
  String? taskNo;
  String? formTypeId;
  String? formTypeName;
  List<PhotosTabDataResponse>? photosTabList;

  CategoriesResponse(
      {this.id,
      this.categoryTitle,
      this.userId,
      this.scheduleId,
      this.groupId,
      this.formId,
      this.formNo,
      this.taskNo,
      this.formTypeId,
      this.formTypeName,
      this.photosTabList});

  @override
  List<Object?> get props => [
        id,
        categoryTitle,
        userId,
        scheduleId,
        groupId,
        formId,
        formNo,
        taskNo,
        formTypeId,
        formTypeName,
        photosTabList
      ];
}

class PhotosTabDataResponse extends Equatable {
  String? id;
  String? tabTitle;
  List<PhotosSelectionDataResponse?>? photosSelectionList;

  PhotosTabDataResponse({this.id, this.tabTitle, this.photosSelectionList});

  @override
  List<Object?> get props => [id, tabTitle, photosSelectionList];
}

class PhotosSelectionDataResponse extends Equatable {
  String? id;
  String? photoTitle;
  List<String> images;
  //List<String?> imagesPathList = [];

  PhotosSelectionDataResponse({
    this.id,
    this.photoTitle,
    required this.images,
    // required this.imagesPathList
  });

  @override
  List<Object?> get props => [id, photoTitle, images];
}
