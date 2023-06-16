import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/certificates_model.dart';
import 'package:eminencetel/features/presentation/bloc/certificates_cubit.dart';
import 'package:eminencetel/features/presentation/pages/widgets/open_file_error_screen.dart';
import 'package:eminencetel/features/presentation/pages/widgets/certificates_widget.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/utils/file_download_utils.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CertificatesScreen extends StatefulWidget {
  const CertificatesScreen({Key? key}) : super(key: key);

  @override
  State<CertificatesScreen> createState() => _CertificatesScreenState();
}

class _CertificatesScreenState extends State<CertificatesScreen> {
  late final List<Certificates> _searchResult = [];

  late List<Certificates>? _myCertificateModelList = [];
  bool progress = false;
  int progressIndex = 0;
  TextEditingController controllerText = TextEditingController();
  var certificatesCubit = getIt<CertificatesCubit>();

  Future refresh() async {
    setState(() {
      certificatesCubit.getCertificates();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CertificatesCubit>(
      create: (_) => certificatesCubit..getCertificates(),
      child: BlocBuilder<CertificatesCubit, DataState<CertificatesModel>>(
          builder: (context, state) {
        _myCertificateModelList = state.data?.data;
        //_searchResult = state.data?.data;
        return Scaffold(
          backgroundColor: Colors.white,
          body: RefreshIndicator(
            onRefresh: refresh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      state.isInProgress
                          ? LinearProgressIndicator(
                              color: CustomColors.black,
                              backgroundColor: CustomColors.white,
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: state.isEmpty
                                  ? [
                                      const Center(
                                        child: Text("No results found"),
                                      )
                                    ]
                                  : _searchResult.isNotEmpty ||
                                          controllerText.text.isNotEmpty
                                      ? List.from(_searchResult.map((item) => CertificatesWidget(
                                                certificateData: item,
                                                currentIndex: 0,
                                                progressIndex: 0,
                                                progressStatus: false,
                                                onClick: () {
                                                  String s = "one.two";
                                                  String result = s.substring(
                                                      0, s.indexOf('.'));

                                                },
                                              )))
                                      : List.from(
                                          _myCertificateModelList!.map(
                                            (item) => CertificatesWidget(
                                                certificateData: item,
                                                currentIndex:
                                                    _myCertificateModelList!
                                                        .indexOf(item),
                                                progressIndex: progressIndex,
                                                progressStatus: progress,
                                                onClick: () {
                                                  setState(() {
                                                    progress = true;
                                                    progressIndex =
                                                        _myCertificateModelList!
                                                            .indexOf(item);
                                                  });
                                                  String responseUrl =
                                                      "${item.url}";
                                                  if (responseUrl != "null" &&
                                                      responseUrl != "") {
                                                    Future<String>
                                                        OpeningResponse =
                                                        FileDownloadUtils()
                                                            .openFile(
                                                                url:
                                                                    responseUrl)
                                                            .whenComplete(() {
                                                      setState(() {
                                                        progress = false;
                                                        progressIndex = 0;
                                                      });
                                                    });
                                                    OpeningResponse.then(
                                                        (value) {
                                                      if (value != "done") {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return OpenFileErrorScreen(
                                                                errorMessage:
                                                                    value);
                                                          },
                                                        );
                                                      }
                                                    });
                                                  }
                                                }),
                                          ),
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

    for (var certificateDetails in _myCertificateModelList!) {
      if (certificateDetails.title
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase())) {
        _searchResult.add(certificateDetails);
      }
    }
    setState(() {});
  }
}
