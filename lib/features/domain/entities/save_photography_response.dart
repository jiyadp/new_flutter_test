import 'package:eminencetel/features/data/models/save_photography_model.dart';
import 'package:equatable/equatable.dart';

class SavePhotographyResponse extends Equatable {
  final List<SavePhotographyData>? data;
  final String? message;
  final bool? success;

  const SavePhotographyResponse({this.data, this.message, this.success});

  @override
  List<Object?> get props => [data, message, success];
}

class SavePhotographyDataResponse extends Equatable {
  final String? id;

  const SavePhotographyDataResponse({this.id});

  @override
  List<Object?> get props => [id];
}
