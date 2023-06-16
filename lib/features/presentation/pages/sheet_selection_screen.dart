import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/photos_model.dart';
import 'package:eminencetel/features/presentation/bloc/photos_cubit.dart';
import 'package:eminencetel/features/presentation/pages/widgets/custom_icon_text_field.dart';
import 'package:eminencetel/features/presentation/pages/widgets/titles_card_widget.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SheetSelectionScreen extends StatefulWidget {
  static const String id = 'sheet_selection_screen';

  const SheetSelectionScreen({Key? key}) : super(key: key);

  @override
  State<SheetSelectionScreen> createState() => _SheetCSelectionScreenState();
}

class _SheetCSelectionScreenState extends State<SheetSelectionScreen> {
  late final List<CategoriesData> _searchResult = [];

  late List<CategoriesData>? _sheetModelList = [];

  TextEditingController controllerText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotosCubit>(
      create: (_) => getIt<PhotosCubit>()..getPhotos(),
      child: BlocBuilder<PhotosCubit, DataState<PhotosModel>>(
          builder: (context, state) {
        _sheetModelList = state.data?.data;
        //_searchResult = state.data?.data;
        return Scaffold(
          appBar: AppBar(
              backgroundColor: CustomColors.black,
              title: const Text("Category")),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomIconTextField(
                  hint: LocaleStrings.title_search,
                  onChanged: onSearchTextChanged,
                  onClick: () {},
                  controller: controllerText,
                  icon: Icon(
                    Icons.search,
                    color: CustomColors.black,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: CustomColors.cardBack,
                            ),
                            color: CustomColors.cardBack,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: state.isInProgress
                              ? LinearProgressIndicator(
                                  color: CustomColors.black,
                                  backgroundColor: CustomColors.white,
                                )
                              : Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: state.isEmpty
                                      ? [
                                          const Center(
                                            child: Text("No results found"),
                                          )
                                        ]
                                      : _searchResult.isNotEmpty ||
                                              controllerText.text.isNotEmpty
                                          ? List.from(_searchResult.map(
                                              (item) => TitlesCardWidget(
                                                title: "${item.categoryTitle}",
                                                onClick: () {
                                                  Navigator.pop(context, item);
                                                },
                                              ),
                                            ))
                                          : List.from(_sheetModelList!.map(
                                              (item) => TitlesCardWidget(
                                                title: "${item.categoryTitle}",
                                                onClick: () {
                                                  Navigator.pop(context, item);
                                                },
                                              ),
                                            ))),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for (var sheetDetails in _sheetModelList!) {
      if (sheetDetails.categoryTitle
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase())) {
        _searchResult.add(sheetDetails);
      }
    }
    setState(() {});
  }
}
