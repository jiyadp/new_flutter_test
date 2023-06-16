import 'package:eminencetel/features/data/models/save_model.dart';
import 'package:equatable/equatable.dart';

class SaveResponse extends Equatable {
  final List<SaveData>? data;
  final String? message;
  final bool? success;

  const SaveResponse({this.data, this.message, this.success});

  @override
  List<Object?> get props => [data, message, success];
}

class SaveDataResponse extends Equatable {
  final String? id;

  const SaveDataResponse({this.id});

  @override
  List<Object?> get props => [id];
}
