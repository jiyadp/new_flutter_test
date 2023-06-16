import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/dynamic_form_model.dart';
import 'package:eminencetel/features/domain/entities/photos_response.dart';
import 'package:eminencetel/features/domain/usecase/dynamic_form_usecase.dart';
import 'package:eminencetel/features/presentation/bloc/dynamic_form_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/save_form_cubit.dart';
import 'package:eminencetel/features/presentation/pages/forms/components/photos_in_form.dart';
import 'package:eminencetel/features/presentation/pages/forms/dynamic_photos_tab_screen.dart';
import 'package:eminencetel/features/presentation/pages/widgets/address_text_field_widget.dart';
import 'package:eminencetel/features/presentation/pages/widgets/custom_button.dart';
import 'package:eminencetel/features/presentation/pages/widgets/custom_text_field_widget.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:eminencetel/features/presentation/utils/custom_dropdown_arguments.dart';
import 'package:eminencetel/features/presentation/utils/form_number_argument.dart';
import 'package:eminencetel/features/presentation/utils/photo_tab_arguments.dart';
import 'package:eminencetel/features/presentation/utils/text_utils.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:eminencetel/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'components/dropdown_selection_screen.dart';

class DynamicFormScreen extends StatefulWidget {
  const DynamicFormScreen({Key? key}) : super(key: key);
  static const String id = 'dynamic_form_screen';

  @override
  State<DynamicFormScreen> createState() => _DynamicFormScreenState();
}

class _DynamicFormScreenState extends State<DynamicFormScreen> {
  late DynamicFormUseCase dynamicFormUseCase;
  final DynamicFormCubit dynamicFormCubit = getIt<DynamicFormCubit>();
  final SaveFormCubit saveFormCubit = getIt<SaveFormCubit>();
  DropdownItemsDetails? dropdownItemsDetails;
  DateTime? selectedDate;
  List<TextEditingController> mainTextEditingControllerList = [];
  List<List<TextEditingController>> cardList = [];
  final _formKey = GlobalKey<FormState>();
  late FormNumberArgument formNumberArgument;
  @override
  Widget build(BuildContext context) {
    formNumberArgument =
        ModalRoute.of(context)!.settings.arguments as FormNumberArgument;
    dynamicFormCubit.getDynamicForm(
        params: DynamicFormParams(
            formId: formNumberArgument.formId,
            scheduleId: formNumberArgument.scheduleId));
    DynamicFormData? mainData;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(formNumberArgument.formName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.primary,
      ),
      body: Form(
        key: _formKey,
        child: BlocProvider<DynamicFormCubit>(
            create: (_) => dynamicFormCubit,
            child: BlocListener<DynamicFormCubit, DataState<DynamicFormModel>>(
              listener: (context, state) {
                mainData = state.data?.dynamicFormData;
              },
              child: BlocBuilder<DynamicFormCubit, DataState<DynamicFormModel>>(
                  builder: (context, dynamicState) {
                List<WidgetDetails>? widgetDataList =
                    dynamicState.data?.dynamicFormData?.items;
                return dynamicState.isInProgress
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  for (var i = 0;
                                      i < widgetDataList!.length;
                                      i++)
                                    Card(
                                      margin: const EdgeInsets.only(
                                          left: 16, right: 16, bottom: 16),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                                child: Text(
                                              widgetDataList[i].title ?? "",
                                              style: CustomTextStyles.bold18(),
                                            )),
                                            Flexible(
                                                child: Text(
                                              widgetDataList[i].description ??
                                                  "",
                                              style: CustomTextStyles
                                                  .descriptionStyle(CustomColors
                                                      .subHeadingColor),
                                            )),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                padding: EdgeInsets.zero,
                                                itemCount: widgetDataList[i]
                                                    .itemDetails
                                                    ?.length,
                                                itemBuilder:
                                                    (context, position) {
                                                  int totalCount =
                                                      widgetDataList[i]
                                                              .itemDetails
                                                              ?.length ??
                                                          0;
                                                  var textController =
                                                      TextEditingController();
                                                  mainTextEditingControllerList
                                                      .add(textController);
                                                  if (position ==
                                                      totalCount - 1) {
                                                    List<TextEditingController>
                                                        newControllerList = [];
                                                    newControllerList.clear();
                                                    for (var element
                                                        in mainTextEditingControllerList) {
                                                      newControllerList
                                                          .add(element);
                                                    }
                                                    cardList
                                                        .add(newControllerList);
                                                    mainTextEditingControllerList
                                                        .clear();
                                                  }

                                                  var items = widgetDataList[i]
                                                      .itemDetails?[position];
                                                  String? title = items?.title;
                                                  bool? required =
                                                      items?.required;
                                                  String? type = items?.type;
                                                  String? inputType =
                                                      items?.inputType;
                                                  int? maxLength =
                                                      items?.maxLength;
                                                  String? hint = items?.hint;
                                                  String? error = items?.error;
                                                  String? value = items?.value;
                                                  List<String>? images =
                                                      items?.images;

                                                  List<DropdownItemsDetails>?
                                                      dropdownList = items
                                                          ?.dropdownItemsDetails;

                                                  return CustomWidgets(
                                                      value: value ?? "",
                                                      type: type ?? "",
                                                      textEditingController:
                                                          textController,
                                                      required:
                                                          required ?? false,
                                                      title: title ?? "",
                                                      inputType:
                                                          inputType ?? "",
                                                      hint: hint ?? "",
                                                      error: error ?? "",
                                                      maxLength: maxLength ?? 0,
                                                      dropdownDetailsList:
                                                          dropdownList ?? [],
                                                      images: images ?? []);
                                                }),
                                          ],
                                        ),
                                      ),
                                    )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: CustomButton(
                                    text: LocaleStrings.next,
                                    onClick: () {
                                      int cardLength = cardList.length;

                                      cardList.forEach((element) {
                                        logger.d("card elements $element");
                                      });
                                      logger.d("card length $cardLength");
                                      logger.d(
                                          "dynamicFormData length ${dynamicState.data?.dynamicFormData?.items?.length}");

                                      // F**king complicated code start
                                      var primaryItems = dynamicState
                                          .data?.dynamicFormData?.items;
                                      primaryItems?.forEach((primaryElement) {
                                        var indexOfPrimary = primaryItems
                                            .indexOf(primaryElement);
                                        var secondaryItems =
                                            primaryElement.itemDetails;
                                        if (secondaryItems?.isNotEmpty ==
                                            true) {
                                          secondaryItems
                                              ?.forEach((secondaryElement) {
                                            var indexOfSecondary =
                                                secondaryItems
                                                    .indexOf(secondaryElement);
                                            for (int i = 0;
                                                i < cardLength;
                                                i++) {
                                              if (indexOfPrimary == i) {
                                                secondaryElement.value =
                                                    cardList[indexOfPrimary]
                                                            [indexOfSecondary]
                                                        .text;
                                              }
                                            }
                                          });
                                        }
                                      });
                                      // F**king complicated code end

                                      if (_formKey.currentState?.validate() ==
                                          true) {
                                        mainData?.taskNo =
                                            formNumberArgument.taskNo;
                                        mainData?.scheduleId =
                                            formNumberArgument.scheduleId;

                                        dynamicFormCubit
                                            .dynamicFormLocalDataSourceSetUseCase
                                            .setUserEnteredData(mainData);

                                        Navigator.pushReplacementNamed(
                                            context, DynamicPhotosTabScreen.id,
                                            arguments: PhotoTabArguments(
                                                formId: mainData?.formId ?? "",
                                                formName:
                                                    formNumberArgument.formName,
                                                formNo:
                                                    formNumberArgument.formNo,
                                                scheduleId: formNumberArgument
                                                    .scheduleId,
                                                siteId:
                                                    formNumberArgument.siteId,
                                                siteName:
                                                    formNumberArgument.siteName,
                                                latitude:
                                                    formNumberArgument.latitude,
                                                longitude: formNumberArgument
                                                    .longitude,
                                                formTypeId:
                                                    mainData?.formTypeId ?? "",
                                                formTypeName:
                                                    mainData?.formTypeName ??
                                                        ""));
                                      } else {
                                        SchedulerBinding.instance
                                            .addPostFrameCallback((_) {
                                          const snackBar = SnackBar(
                                              content: Text(
                                                  "Please fill out all required fields."));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        });
                                      }
                                    },
                                    buttonColor: CustomColors.appBarColor),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ));
              }),
            )),
      ),
    );
  }

  Widget CustomWidgets(
      {required String type,
      required bool required,
      required String title,
      required String inputType,
      required String hint,
      required String error,
      required int maxLength,
      required String value,
      required TextEditingController textEditingController,
      required List<DropdownItemsDetails> dropdownDetailsList,
      required List<String> images}) {
    switch (type) {
      case "image":
        return PhotosForm(
            photosSelectionDataResponse: PhotosSelectionDataResponse(
                id: "", photoTitle: title, images: images),
            formNumberArgument: formNumberArgument);
      case "textformfield":
        return CustomTextFieldWidget(
          value: value,
          textEditingController: textEditingController,
          hint: hint,
          textInputType:
              inputType == "number" ? TextInputType.number : TextInputType.text,
          onChanged: (value) {},
          validator: (value) {
            return required == true ? TextUtils.emptyValidation(value!) : null;
          },
          onClick: () {},
        );

      case "largeTextFormField":
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: AddressTextFieldWidget(
            value: value,
            textEditingController: textEditingController,
            hint: hint,
            textInputType: inputType == "number"
                ? TextInputType.number
                : TextInputType.text,
            onChanged: (value) {},
            onClick: () {},
            validator: (value) {
              return required == true
                  ? TextUtils.emptyValidation(value!)
                  : null;
            },
          ),
        );

      //todo Check dropdown Id issue
      case "dropdown":
        return CustomTextFieldWidget(
          value: value,
          textEditingController: textEditingController,
          hint: hint,
          onChanged: (value) {},
          validator: (value) {
            return required == true ? TextUtils.emptyValidation(value!) : null;
          },
          readOnly: true,
          onClick: () {
            selectedItem(textEditingController, dropdownDetailsList);
          },
        );

      case "datepicker":
        return CustomTextFieldWidget(
          value: value,
          hint: hint,
          onChanged: (value) {},
          readOnly: true,
          onClick: () {
            _selectDate(context, textEditingController);
          },
          validator: (value) {
            return TextUtils.emptyValidation(textEditingController.text);
          },
          textEditingController: textEditingController,
        );

      default:
        return const SizedBox(
          height: 4,
        );
    }
  }

  Future<void> selectedItem(TextEditingController dropDownController,
      List<DropdownItemsDetails> dropdownDetailsList) async {
    final result = await Navigator.pushNamed(
        context, DropdownSelectionScreen.id,
        arguments: CustomDropdownArguments(itemList: dropdownDetailsList));
    DropdownItemsDetails response = (result as DropdownItemsDetails);
    dropDownController.text = response.title!;
  }

  DateFormat formatter = DateFormat('dd-MM-yyyy');
  Future<void> _selectDate(
      BuildContext context, TextEditingController datePickerController) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1000, 1),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      // setState(() {
      selectedDate = picked;
      datePickerController.text = formatter.format(selectedDate!);
      //});
    }
  }
}
