import 'package:eminencetel/features/domain/entities/photos_response.dart';

class PhotosModel extends PhotosResponse {
  PhotosModel({List<CategoriesData>? data, String? message, bool? success})
      : super(data: data, message: message, success: success);

  factory PhotosModel.fromJson(Map<String, dynamic> json) => PhotosModel(
      data: json['data'] != null
          ? json['data']!
              .map<CategoriesData>((data) => CategoriesData.fromJson(data))
              .toList()
          : null,
      message: json['message'],
      success: json['success']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = data;
    data['message'] = message;
    data['success'] = success;
    return data;
  }
}

class CategoriesData extends CategoriesResponse {
  CategoriesData(
      {String? id,
      String? groupName,
      String? userId,
      String? scheduleId,
      String? groupId,
      String? formId,
      String? formNo,
      String? taskNo,
      String? formTypeId,
      String? formTypeName,
      List<PhotoTabData>? photosTabList})
      : super(
            id: id,
            categoryTitle: groupName,
            userId: userId,
            scheduleId: scheduleId,
            groupId: groupId,
            formId: formId,
            formNo: formNo,
            taskNo: taskNo,
            formTypeId:formTypeId,
            formTypeName:formTypeName,
            photosTabList: photosTabList);

  factory CategoriesData.fromJson(Map<String, dynamic> json) {
    return CategoriesData(
        id: json['_id'],
        groupName: json['strGroupName'],
        userId: json['userId'],
        scheduleId: json['scheduleId'],
        groupId: json['group_id'],
        formId: json['formId'],
        formNo: json['formNo'],
        taskNo: json['taskNo'],
        formTypeId: json['formTypeId'],
        formTypeName: json['formTypeName'],
        photosTabList: json['datasOfGroup'] != null
            ? json['datasOfGroup']!
                .map<PhotoTabData>((data) => PhotoTabData.fromJson(data))
                .toList()
            : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['strGroupName'] = categoryTitle;
    data['datasOfGroup'] = photosTabList;
    data['userId'] = userId;
    data['scheduleId'] = scheduleId;
    data['group_id'] = groupId;
    data['formId'] = formId;
    data['formNo'] = formNo;
    data['taskNo'] = taskNo;
    data['formTypeId'] = formTypeId;
    data['formTypeName'] = formTypeName;
    return data;
  }
}

class PhotoTabData extends PhotosTabDataResponse {
  PhotoTabData(
      {String? id,
      String? tabTitle,
      List<PhotosSelectionDataResponse>? photosSelectionList})
      : super(
            id: id,
            tabTitle: tabTitle,
            photosSelectionList: photosSelectionList);

  factory PhotoTabData.fromJson(Map<String, dynamic> json) {
    return PhotoTabData(
        id: json['_id'],
        tabTitle: json['strPhotographyName'],
        photosSelectionList: json['arrayOfSubPhotography'] != null
            ? json['arrayOfSubPhotography']!
                .map<PhotosDetails>((data) => PhotosDetails.fromJson(data))
                .toList()
            : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['strPhotographyName'] = tabTitle;
    data['arrayOfSubPhotography'] = photosSelectionList;
    return data;
  }
}

class PhotosDetails extends PhotosSelectionDataResponse {
  PhotosDetails(
      {String? id,
      String? photoTitle,
      List<String>? images,
      List<String>? imagesPathList})
      : super(
          id: id,
          photoTitle: photoTitle,
          images: images ?? [],
        );

  factory PhotosDetails.fromJson(Map<String, dynamic> json) {
    return PhotosDetails(
        id: json['_id'],
        photoTitle: json['strSubPhotographyName'],
        images: json['arrayOfImageUrl'] != null
            ? json['arrayOfImageUrl']!
                .map<String>((data) => data as String)
                .toList()
            : null,
        imagesPathList: json['localPath'] != null
            ? json['localPath']!.map<String>((data) => data as String).toList()
            : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['strSubPhotographyName'] = photoTitle;
    data['arrayOfImageUrl'] = images;
    // data['localpath'] = imagesPathList;
    return data;
  }
}
