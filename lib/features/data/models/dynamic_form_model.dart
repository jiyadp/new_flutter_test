class DynamicFormModel {
  final bool? success;
  final String? message;
  final DynamicFormData? dynamicFormData;

  const DynamicFormModel({this.success, this.message, this.dynamicFormData});

  factory DynamicFormModel.fromJson(Map<String, dynamic> json) =>
      DynamicFormModel(
        success: json['success'],
        message: json['message'],
        dynamicFormData: json['data'] != null
            ? DynamicFormData.fromJson(json['data'])
            : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = dynamicFormData;
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class DynamicFormData {
  final List<WidgetDetails>? items;
  String? formNo;
  String? name;
  final GroupData? groupData;
  String? scheduleId;
  String? formId;
  String? userId;
  String? taskNo;
  String? formTypeId;
  String? formTypeName;

  DynamicFormData(
      {this.items,
      this.formNo,
      this.name,
      this.groupData,
      this.scheduleId,
      this.formId,
      this.userId,
      this.taskNo,
      this.formTypeId,
      this.formTypeName});

  factory DynamicFormData.fromJson(Map<String, dynamic> json) {
    return DynamicFormData(
      formNo: json['formNo'],
      name: json['name'],
      groupData: json['group'] == null || json['group'].toString() == '[]'
          ? null
          : GroupData.fromJson(json['group']),
      // json['group'] != null ? GroupData.fromJson(json['group']) : null,
      items: json['items'] != null
          ? json['items']!
              .map<WidgetDetails>((data) => WidgetDetails.fromJson(data))
              .toList()
          : null,
      scheduleId: json['scheduleId'],
      formId: json['formId'],
      userId: json['userId'],
      taskNo: json['taskNo'],
      formTypeId: json['formTypeId'],
      formTypeName: json['formTypeName']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['formNo'] = formNo;
    data['name'] = name;
    data['group'] = groupData;
    data['items'] = items;
    data['scheduleId'] = scheduleId;
    data['formId'] = formId;
    data['userId'] = userId;
    data['taskNo'] = taskNo;
    data['formTypeId'] = formTypeId;
    data['formTypeName'] = formTypeName;
    return data;
  }

  List<Object?> get props =>
      [items, formNo, name, groupData, scheduleId, formId, userId, taskNo, formTypeId, formTypeName];
}

class WidgetDetails {
  final String? id;
  final String? title;
  final String? description;
  final List<ItemsDetails>? itemDetails;

  const WidgetDetails({this.id, this.title, this.itemDetails, this.description});

  factory WidgetDetails.fromJson(Map<String, dynamic> json) {
    return WidgetDetails(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      itemDetails: json['items'] != null
          ? json['items']!
              .map<ItemsDetails>((data) => ItemsDetails.fromJson(data))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['items'] = itemDetails;
    data['description'] = description;
    return data;
  }

  List<Object?> get props => [id,title, itemDetails, description];
}

class ItemsDetails {
  final String? itemId;
  final String? type;
  final String? title;
  final String? hint;
  final String? error;
  final bool? required;
  String? value;
  final String? inputType;
  final int? maxLength;
  final List<DropdownItemsDetails>? dropdownItemsDetails;
  final List<String>? images;

  ItemsDetails(
      {this.itemId,
      this.type,
      this.title,
      this.hint,
      this.error,
      this.required,
      this.inputType,
      this.maxLength,
      this.value,
      this.dropdownItemsDetails,
      this.images});

  factory ItemsDetails.fromJson(Map<String, dynamic> json) {
    return ItemsDetails(
      itemId: json['itemId'],
      type: json['type'],
      title: json["title"],
      hint: json['hint'],
      error: json['error'],
      required: json['required'],
      inputType: json['input_type'],
      maxLength: json['max_length'],
      value: json['value'],
      dropdownItemsDetails: json['items'] != null
          ? json['items']!
              .map<DropdownItemsDetails>(
                  (data) => DropdownItemsDetails.fromJson(data))
              .toList()
          : null,
      images: json['images'] != null ? json['images']!
        .map<String>((data) => data as String)
        .toList()
        : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemId'] = itemId;
    data['type'] = type;
    data["title"] = title;
    data['hint'] = hint;
    data['error'] = error;
    data['required'] = required;
    data['input_type'] = inputType;
    data['max_length'] = maxLength;
    data['value'] = value;
    data['items'] = dropdownItemsDetails;
    data['images'] = images;
    return data;
  }

  List<Object?> get props => [
        itemId,
        type,
        title,
        hint,
        error,
        required,
        inputType,
        maxLength,
        value,
        dropdownItemsDetails,
        images
      ];
}

class DropdownItemsDetails {
  final String? title;
  final int? id;

  const DropdownItemsDetails({
    this.title,
    this.id,
  });

  factory DropdownItemsDetails.fromJson(Map<String, dynamic> json) {
    return DropdownItemsDetails(
      id: json['id'],
      title: json["title"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data["title"] = title;

    return data;
  }

  List<Object?> get props => [id, title];
}

class GroupData {
  String? id;
  final String? groupName;

  GroupData({this.id, this.groupName});

  factory GroupData.fromJson(Map<String, dynamic> json) {
    return GroupData(
      id: json['_id'],
      groupName: json['groupName'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['groupName'] = groupName;
    return data;
  }

  List<Object?> get props => [id, groupName];
}
