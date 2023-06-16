import 'package:eminencetel/features/data/models/photos_model.dart';

class FiberHopeModel {
  String? id;
  String? projectId;
  String? projectName;
  String? projectDate;
  String? mspId;
  String? mspName;
  String? swcId;
  String? swcName;
  String? leadEngineer;
  String? cellId;
  String? cellName;
  String? siteName;
  String? siteType;
  String? siteAddress;
  String? postalCode;
  CategoriesData? categoriesData;
  String? description;
  String? comments;
  String? userId;

  FiberHopeModel(
      {this.id,
      this.projectId,
      this.projectName,
      this.projectDate,
      this.mspId,
      this.mspName,
      this.swcId,
      this.swcName,
      this.leadEngineer,
      this.cellId,
      this.cellName,
      this.siteName,
      this.siteType,
      this.siteAddress,
      this.postalCode,
      this.categoriesData,
      this.description,
      this.comments,
      this.userId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['intProjectId'] = projectId;
    data['strProjectName'] = projectName;
    data['datProjectDate'] = projectDate;
    data['intMSPId'] = mspId;
    data['strMSPName'] = mspName;
    data['intSWCId'] = swcId;
    data['strSWCName'] = swcName;
    data['strLeadEngineer'] = leadEngineer;
    data['intCellId'] = cellId;
    data['strCellName'] = cellName;
    data['strSiteName'] = siteName;
    data['strSiteType'] = siteType;
    data['strSiteAddress'] = siteAddress;
    data['strPostalCode'] = postalCode;
    data['objSheet'] = categoriesData?.toJson();
    data['strDescription'] = description;
    data['strComments'] = comments;
    data['fkIntCreateUserId'] = userId;
    return data;
  }

  factory FiberHopeModel.fromJson(Map<String, dynamic> json) => FiberHopeModel(
      id: json['_id'],
      projectId: json['intProjectId'],
      projectName: json['strProjectName'],
      projectDate: json['datProjectDate'],
      mspId: json['intMSPId'],
      mspName: json['strMSPName'],
      swcId: json['intSWCId'],
      swcName: json['strSWCName'],
      leadEngineer: json['strLeadEngineer'],
      cellId: json['intCellId'],
      cellName: json['strCellName'],
      siteName: json['strSiteName'],
      siteType: json['strSiteType'],
      siteAddress: json['strSiteAddress'],
      postalCode: json['strPostalCode'],
      categoriesData: json['objSheet'] != null
          ? CategoriesData.fromJson(json['objSheet'])
          : null,
      description: json['strDescription'],
      comments: json['strComments'],
      userId: json['fkIntCreateUserId']);
}
