import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/photos_model.dart';
import 'package:eminencetel/features/domain/entities/photos_response.dart';
import 'package:eminencetel/features/presentation/bloc/photos_cubit.dart';
import 'package:eminencetel/features/presentation/pages/forms/photos/photo_uploading_future.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/utils/form_number_argument.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoUploadingScreen extends StatefulWidget {
  static const String id = 'feeder_and_fiber_rigging';
  final List<PhotosSelectionDataResponse?>? photosSelectionDataResponse;
  final int? tabPosition;
  final FormNumberArgument? formNumberArgument;

  PhotoUploadingScreen({
    Key? key,
    this.photosSelectionDataResponse,
    this.tabPosition,
    this.formNumberArgument,
  }) : super(key: key);

  @override
  State<PhotoUploadingScreen> createState() => _PhotoUploadingScreenState();
}

class _PhotoUploadingScreenState extends State<PhotoUploadingScreen> {
  var photoCubit = getIt<PhotosCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotosCubit>(
        create: (_) => photoCubit,
        child: BlocBuilder<PhotosCubit, DataState<PhotosModel>>(
            builder: (context, state) {
          return Scaffold(
            backgroundColor: CustomColors.white,
            body: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      PhotoUploadingFuture(
                        tabPosition: widget.tabPosition ?? 0,
                        formNumberArgument: widget.formNumberArgument,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
