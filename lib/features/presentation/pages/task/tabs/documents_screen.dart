import 'dart:io';
import 'package:eminencetel/features/data/models/schedule_details_model.dart';
import 'package:eminencetel/features/presentation/bloc/schedule_details_cubit.dart';
import 'package:eminencetel/features/presentation/pages/widgets/open_file_error_screen.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:eminencetel/features/presentation/utils/file_download_utils.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class DocumentsScreen extends StatefulWidget {
  static const String id = 'documents_screen';
  final BuildContext tabContext;

  const DocumentsScreen({Key? key, required this.tabContext}) : super(key: key);

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  var scheduleDetailsCubit = getIt<ScheduleDetailsCubit>();
  bool progress = false;
  int progressIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Documents?>? documents = scheduleDetailsCubit.getSchedules().documents;
    return Scaffold(
      body: Container(
        color: CustomColors.white,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            //  widget.heartFailureCenterFuture,
            FutureBuilder(builder: (context, AsyncSnapshot snapshot) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return ExpansionPanelList(
                  expandedHeaderPadding: EdgeInsets.zero,
                  elevation: 0,
                  dividerColor: CustomColors.white,
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      documents?[index]?.isExpanded = !isExpanded;
                    });
                  },
                  animationDuration: const Duration(milliseconds: 500),
                  children: documents?.map<ExpansionPanel>((Documents? item) {
                        return ExpansionPanel(
                          canTapOnHeader: true,
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              title: Text("${item?.type?.toString()}",
                                  style: CustomTextStyles.boldCheckList()),
                            );
                          },
                          body: (item?.files?.length ?? 0) > 0
                              ? ListView.builder(
                                  itemCount: item?.files?.length ?? 0,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String? fileUrl = item?.files?[index].file;
                                    final File file = File(fileUrl ?? "");
                                    final filename = basename(file.path);
                                    final file_extension = extension(file.path);

                                    return ListTile(
                                      title: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              progress = true;
                                              progressIndex = index;
                                            });
                                            String responseUrl =
                                                "${item?.files?[index].file}";
                                            if (responseUrl != "null" &&
                                                responseUrl != "") {
                                              Future<String> OpeningResponse =
                                                  FileDownloadUtils()
                                                      .openFile(
                                                          url: responseUrl)
                                                      .whenComplete(() {
                                                setState(() {
                                                  progress = false;
                                                  progressIndex = 0;
                                                });
                                              });
                                              OpeningResponse.then((value) {
                                                if (value != "done") {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return OpenFileErrorScreen(
                                                          errorMessage: value);
                                                    },
                                                  );
                                                }
                                              });
                                            }
                                          },
                                          child: progress &&
                                                  progressIndex == index
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : Row(
                                                  children: [
                                                    iconTypeWidget(file_extension),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(filename)),
                                                  ],
                                                )),
                                      trailing: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            progress = true;
                                            progressIndex = index;
                                          });
                                          String responseUrl =
                                              "${item?.files?[index].file}";
                                          if (responseUrl != "null" &&
                                              responseUrl != "") {
                                            Future<String> OpeningResponse =
                                                FileDownloadUtils()
                                                    .openFile(url: responseUrl)
                                                    .whenComplete(() {
                                              setState(() {
                                                progress = false;
                                                progressIndex = 0;
                                              });
                                            });
                                            OpeningResponse.then((value) {
                                              if (value != "done") {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return OpenFileErrorScreen(
                                                        errorMessage: value);
                                                  },
                                                );
                                              }
                                            });
                                          }
                                        },
                                        child: progress &&
                                                progressIndex == index
                                            ? Icon(
                                                Icons.downloading,
                                                color: CustomColors.appBarColor,
                                              )
                                            : Icon(
                                                Icons.download,
                                                color: CustomColors.appBarColor,
                                              ),
                                      ),
                                    );
                                  },
                                )
                              : const Center(child: Text('No items')),
                          isExpanded: item?.isExpanded ?? false,
                        );
                      }).toList() ??
                      [],
                );
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget iconTypeWidget(String extensionType) {
    switch (extensionType) {
      case ".jpg":
        return const Icon(Icons.image_outlined);

      case ".jpeg":
        return const Icon(Icons.image_outlined);

      case ".png":
        return const Icon(Icons.image_outlined);

      case ".svg":
        return const Icon(Icons.image_outlined);

      case ".doc":
        return const Icon(Icons.wordpress);

      case ".pdf":
        return const Icon(Icons.picture_as_pdf_outlined);

      case ".xlsx":
        return const Icon(Icons.list_alt);

      case ".xls":
        return const Icon(Icons.list_alt);

      case ".docx":
        return const Icon(Icons.wordpress);

      default:
        return const Icon(Icons.error);
    }
  }
}
