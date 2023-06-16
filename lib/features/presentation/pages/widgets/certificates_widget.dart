import 'package:eminencetel/features/data/models/certificates_model.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:eminencetel/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CertificatesWidget extends StatelessWidget {
  final Certificates certificateData;
  final Function() onClick;
  final bool progressStatus;
  final int progressIndex;
  final int currentIndex;
  const CertificatesWidget(
      {Key? key,
      required this.certificateData,
      required this.onClick,
      required this.currentIndex,
      required this.progressStatus,
      required this.progressIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formatter = DateFormat('dd-MM-yyyy');
    var startDate = DateTime.parse("${certificateData.startDate}");
    var endDate = DateTime.parse("${certificateData.endDate}");
    var formattedStartDate = formatter.format(startDate);
    var formattedEndDate = formatter.format(endDate);

    // Create a DateTime object for the current date
    DateTime now = DateTime.now();

    // Get the difference between the two dates in months
    int differenceInMonths = endDate.difference(now).inDays ~/ 30;

    // Compare the difference in months to a threshold (in this case, 6 months)
    var colorCode = CustomColors.certificatesCardBG;
    if (differenceInMonths <= 1) {
      colorCode = CustomColors.certificatesCardBGRed;
      logger.d('The expiry date is less than 1 month away. $colorCode');
    } else if (differenceInMonths <= 2) {
      colorCode = CustomColors.certificatesCardBGOrange;
      logger.d('The expiry date is less than 2 months away. $colorCode');
    } else {
      colorCode = CustomColors.cardColor;
      logger.d('The expiry date is more than 2 months away. $colorCode');
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 16, right: 16, top: 5),
      child: GestureDetector(
        onTap: onClick,
        child: Card(
          elevation: 2,
          color: CustomColors.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          margin: EdgeInsets.zero,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${certificateData.title}",
                      style: CustomTextStyles.headingBold(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                  child: Text(
                                LocaleStrings.certificates_card_label_startDate,
                                style: CustomTextStyles.subheading(),
                              )),
                              Flexible(
                                child: Text(
                                  formattedStartDate,
                                  style: CustomTextStyles.subheadingBold(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                  child: Text(
                                LocaleStrings.certificates_card_label_endDate,
                                style: CustomTextStyles.subheading(),
                              )),
                              Flexible(
                                child: Text(
                                  formattedEndDate,
                                  style: CustomTextStyles.subheadingBold(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleStrings.certificates_card_label_type,
                          style: CustomTextStyles.subheading(),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "${certificateData.type}",
                            style: CustomTextStyles.subheadingBold(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    statusWidget(backgroundColor: colorCode)
                  ],
                ),
              ),
              progressStatus && progressIndex == currentIndex
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget statusWidget({required Color backgroundColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: backgroundColor),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text("Renew",
                    style: TextStyle(color: CustomColors.cardColor))))
      ],
    );
  }
}
