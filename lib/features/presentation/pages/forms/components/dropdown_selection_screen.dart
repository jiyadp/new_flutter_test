import 'package:eminencetel/features/data/models/dynamic_form_model.dart';
import 'package:eminencetel/features/presentation/pages/widgets/custom_icon_text_field.dart';
import 'package:eminencetel/features/presentation/pages/widgets/titles_card_widget.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:eminencetel/features/presentation/utils/custom_dropdown_arguments.dart';
import 'package:flutter/material.dart';

class DropdownSelectionScreen extends StatefulWidget {
  static const String id = 'dropdown_selection_screen';

  const DropdownSelectionScreen({Key? key}) : super(key: key);

  @override
  State<DropdownSelectionScreen> createState() =>
      _DropdownSelectionScreenState();
}

class _DropdownSelectionScreenState extends State<DropdownSelectionScreen> {
  String searchValue = '';

  List<DropdownItemsDetails> dropdownItemsList = [];
  List<DropdownItemsDetails> searchResult = [];

  TextEditingController controllerText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CustomDropdownArguments argumentsModel =
        ModalRoute.of(context)!.settings.arguments as CustomDropdownArguments;
    dropdownItemsList = argumentsModel.itemList;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: CustomColors.appBarColor,
          title: const Text("Items")),
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: dropdownItemsList.isNotEmpty ||
                                  controllerText.text.isNotEmpty
                              ? List.from(dropdownItemsList.map(
                                  (item) => TitlesCardWidget(
                                    title: "${item.title}",
                                    onClick: () {
                                      Navigator.pop(context, item);
                                    },
                                  ),
                                ))
                              : List.from(searchResult.map(
                                  (item) => TitlesCardWidget(
                                    title: "${item.title}",
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
  }

  onSearchTextChanged(String text) async {
    searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for (var itemDetails in dropdownItemsList) {
      if (itemDetails.title
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase())) searchResult.add(itemDetails);
    }
    setState(() {});
  }
}
