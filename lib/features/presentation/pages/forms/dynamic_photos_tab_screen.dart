import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/dynamic_photos_tab_model.dart';
import 'package:eminencetel/features/data/models/photos_model.dart';
import 'package:eminencetel/features/data/models/save_photography_model.dart';
import 'package:eminencetel/features/domain/usecase/dynamic_photos_tab_usecase.dart';
import 'package:eminencetel/features/presentation/bloc/dynamic_form_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/dynamic_photos_tab_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/save_form_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/save_photography_cubit.dart';
import 'package:eminencetel/features/presentation/pages/forms/photos/photo_uploading_screen.dart';
import 'package:eminencetel/features/presentation/pages/widgets/custom_button.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:eminencetel/features/presentation/utils/form_number_argument.dart';
import 'package:eminencetel/features/presentation/utils/photo_tab_arguments.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DynamicPhotosTabScreen extends StatelessWidget {
  const DynamicPhotosTabScreen({Key? key}) : super(key: key);
  static const String id = 'photo_uploading_screen';

  @override
  Widget build(BuildContext context) {
    PhotoTabArguments? arguments =
        ModalRoute.of(context)!.settings.arguments as PhotoTabArguments?;

    final DynamicFormCubit dynamicFormCubit = getIt<DynamicFormCubit>();
    final DynamicPhotosTabCubit dynamicPhotosTabCubit =
        getIt<DynamicPhotosTabCubit>();
    final SaveFormCubit saveFormCubit = getIt<SaveFormCubit>();
    final SavePhotographyCubit savePhotographyCubit =
        getIt<SavePhotographyCubit>();
    TabController? tabController;
    List<Tab> titleTab = [];
    List<Widget> contentWidget = [];

    return BlocProvider<DynamicPhotosTabCubit>(
      create: (_) => dynamicPhotosTabCubit
        ..getDynamicPhotosTabData(
            params: DynamicPhotosTabParams(
                formId: arguments!.formId,formName: arguments.formName, scheduleId: arguments.scheduleId)),
      child:
          BlocBuilder<DynamicPhotosTabCubit, DataState<DynamicPhotosTabModel>>(
        builder: (context, state) {
          var userEnteredData = dynamicFormCubit.getLocalDynamicFormData();
          if (state.isSuccess) {
            CategoriesData? categoriesData = state.data?.categoriesData;
            categoriesData?.formId = arguments?.formId;
            categoriesData?.scheduleId = arguments?.scheduleId;
            categoriesData?.scheduleId = arguments?.scheduleId;
            categoriesData?.formTypeId = arguments?.formTypeId;
            categoriesData?.formTypeName = arguments?.formTypeName;
            categoriesData?.taskNo = userEnteredData.taskNo;
            categoriesData?.userId = userEnteredData.userId;
            categoriesData?.groupId = userEnteredData.groupData?.id;
            categoriesData?.formNo = userEnteredData.formNo;
            dynamicPhotosTabCubit.dynamicPhotosTabLocalDataSourceSetUseCase
                .setUserEnteredData(categoriesData);

            var photosDetails = categoriesData?.photosTabList;
            if (photosDetails != null) {
              for (int i = 0; i < photosDetails.length; i++) {
                var photoTabDetails = photosDetails[i];
                titleTab.add(Tab(
                  text: photoTabDetails.tabTitle,
                ));
                contentWidget.add(PhotoUploadingScreen(
                  photosSelectionDataResponse:
                      photoTabDetails.photosSelectionList,
                  tabPosition: i,
                  formNumberArgument: FormNumberArgument(
                      formId: arguments?.formId ?? "",
                      formName: arguments?.formName ?? "",
                      formNo: arguments?.formNo ?? "",
                      latitude: arguments?.latitude ?? "",
                      longitude: arguments?.longitude ?? "",
                      scheduleId: arguments?.scheduleId ?? "",
                      siteId: arguments?.siteId ?? "",
                      siteName: arguments?.siteName ?? "",
                      taskNo: userEnteredData.taskNo ?? "",
                  ),
                  // editEnabled: arguments?.touchDisable,
                ));
              }
            }
            return SafeArea(
              child: DefaultTabController(
                length: titleTab.length,
                child: Builder(builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      title: Text("${arguments?.formName}"),
                      backgroundColor: CustomColors.primary,
                      elevation: 0.5,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(
                            MediaQuery.of(context).size.width / 6.5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TabBar(
                              controller: tabController,
                              onTap: (value) {},
                              isScrollable: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              labelStyle: CustomTextStyles.tabTextStyle(),
                              labelColor: CustomColors.white,
                              unselectedLabelColor:
                                  CustomColors.white.withAlpha(100),
                              unselectedLabelStyle:
                                  CustomTextStyles.tabTextStyle(),
                              indicatorColor: CustomColors.white,
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorPadding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              tabs: titleTab),
                        ),
                      ),
                    ),
                    body: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            flex: 12,
                            child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: contentWidget)),
                        BlocProvider<SavePhotographyCubit>(
                            create: (_) => savePhotographyCubit,
                            child: BlocListener<SavePhotographyCubit,
                                DataState<SavePhotographyModel>>(
                              listener: (context, state) {},
                              child: BlocBuilder<SavePhotographyCubit,
                                      DataState<SavePhotographyModel>>(
                                  builder: (context, state) {
                                if (state.isSuccess) {
                                  SchedulerBinding.instance
                                      .addPostFrameCallback((_) {
                                    saveFormData(
                                        dynamicFormCubit, saveFormCubit);
                                    var snackBar = SnackBar(
                                        content:
                                            Text(state.data?.message ?? ""));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  });
                                }
                                return state.isInProgress
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: CustomButton(
                                          buttonColor: CustomColors.primary,
                                          text: LocaleStrings.save,
                                          isLoading: state.isInProgress,
                                          onClick: () {
                                            var dynamicPhotosData =
                                                dynamicPhotosTabCubit
                                                    .dynamicPhotosTabLocalDataSourceGetUseCase
                                                    .getUserEnteredData();
                                            context
                                                .read<SavePhotographyCubit>()
                                                .savePhotography(
                                                    params: dynamicPhotosData);
                                          },
                                        ));
                              }),
                            )),
                        // BlocProvider<SaveFormCubit>(
                        //   create: (_) =>
                        //       saveFormCubit..saveForm(params: userEnteredData),
                        //   child: BlocBuilder<SaveFormCubit,
                        //           DataState<SaveFormModel>>(
                        //       builder: (context, state) {
                        //     if (state.isSuccess) {
                        //       SchedulerBinding.instance
                        //           .addPostFrameCallback((_) {
                        //         final snackBar = SnackBar(
                        //             content: Text("${state.data?.message}"));
                        //         ScaffoldMessenger.of(context)
                        //             .showSnackBar(snackBar);
                        //       });
                        //     }
                        //     return const SizedBox();
                        //   }),
                        // )
                      ],
                    ),
                  );
                }),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: CustomColors.white,
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  saveFormData(DynamicFormCubit dynamicFormCubit, SaveFormCubit saveFormCubit) {
    var userEnteredData = dynamicFormCubit.dynamicFormLocalDataSourceGetUseCase
        .getUserEnteredData();
    saveFormCubit.saveForm(params: userEnteredData);
  }
}
