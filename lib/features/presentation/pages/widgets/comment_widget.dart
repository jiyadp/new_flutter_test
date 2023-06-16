import 'package:flutter/material.dart';



enum MessageType {
  sent,
  received,
}

class CommentWidget extends StatelessWidget {
  final String name;
  final String time;
  final String email;
  final String comment;
  final MessageType messageType;

  const CommentWidget({
    Key? key,
    required this.name,
    required this.time,
    required this.email,
    required this.comment,
    required this.messageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (messageType == MessageType.sent) const Spacer(),
          if (messageType == MessageType.received)
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
            ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    // Text(
                    //   time,
                    //   style: const TextStyle(
                    //     fontSize: 12,
                    //     color: Colors.grey,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: messageType == MessageType.sent
                        ? Colors.greenAccent
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment,
                        //  + messageType.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: messageType == MessageType.sent
                              ? Colors.black
                              : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Text(
                          time,
                          // Format the date
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (messageType == MessageType.received) const Spacer(),
          if (messageType == MessageType.sent)
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
            ),
        ],
      ),
    );
  }
}





































// import 'package:eminencetel/features/presentation/res/custom_colors.dart';
// import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class CommentWidget extends StatelessWidget {
//   final String name;
//   final String time;
//   final String email;
//   final String comment;

//   const CommentWidget(
//       {Key? key,
//       required this.name,
//       required this.time,
//       required this.email,
//       required this.comment})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var dateTime = DateTime.parse(time);
//     final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm aa');
//     final String formattedDate = formatter.format(dateTime);
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.asset(
//             'assets/images/user.png',
//             fit: BoxFit.fill,
//             height: 45,
//             width: 45,
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           Flexible(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Flexible(
//                       flex: 1,
//                       child: Text(
//                         name,
//                         style: CustomTextStyles.headingBold(),
//                         textAlign: TextAlign.start,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 8,
//                     ),
//                     Flexible(
//                         child: Text(
//                       formattedDate,
//                       textAlign: TextAlign.start,
//                       style: CustomTextStyles.smallHeading(),
//                     ))
//                   ],
//                 ),
//                 Text(
//                   email,
//                   style: CustomTextStyles.smallHeading(),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   comment,
//                   style: CustomTextStyles.regular14(CustomColors.black),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
