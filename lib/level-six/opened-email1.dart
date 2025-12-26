// import 'package:flame/components.dart';
// import 'package:flame/experimental.dart' hide RoundedRectangle;
// import 'package:flutter/material.dart';
// import 'package:hack_improved/components/main_container.dart';
// import 'package:hack_improved/components/rounded_rectangle.dart';
// import 'package:hack_improved/constants.dart';
// import 'package:hack_improved/level-six/opened_email1.dart';
// import 'package:hack_improved/level-six/phishing_button.dart';
// import 'package:hack_improved/level-six/safe_button.dart';
// import 'package:hack_improved/level-six/tofind_values.dart';

// class OpenedEmail1 extends PositionComponent {
//   late Email1Content emailContent;
//   late PhishingButton phishing;
//   late SafeButton safe;
//   String fromEmail;
//   String subjectEmail;
//   String dateEmail;

//   @override
//   // TODO: implement debugMode
//   bool get debugMode => false;

//   OpenedEmail1({
//     required this.fromEmail,
//     required this.subjectEmail,
//     required this.dateEmail,
//   }) : super(size: Vector2(1500, 724));

//   @override
//   Future<void> onLoad() async {
//     emailContent = Email1Content();
//     // -- EmailHeader
//     // size: Vector2(1206, 134)
//     RowComponent fromEmailHeader = RowComponent(
//       size: Vector2(1206 - 48, 30),
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         PositionComponent(
//           size: Vector2(150, 30),
//           children: [
//             TextComponent(
//               size: Vector2(100, 30),
//               text: "From:",
//               textRenderer: TextPaint(
//                 style: TextStyle(
//                   fontSize: 32,
//                   color: ThemeColors.checkServerStatusText,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         ToFindValues(
//           content: TextComponent(
//             text: fromEmail,
//             textRenderer: TextPaint(
//               style: TextStyle(fontSize: 32, color: Colors.white),
//             ),
//           ),
//         ),
//       ],
//     );

//     RowComponent subjectEmailHeader = RowComponent(
//       size: Vector2(1206 - 48, 30),
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         PositionComponent(
//           size: Vector2(150, 30),
//           children: [
//             TextComponent(
//               text: "Subject:",
//               textRenderer: TextPaint(
//                 style: TextStyle(
//                   fontSize: 32,
//                   color: ThemeColors.checkServerStatusText,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         TextComponent(
//           text: subjectEmail,
//           textRenderer: TextPaint(
//             style: TextStyle(fontSize: 32, color: Colors.white),
//           ),
//         ),
//       ],
//     );

//     RowComponent dateEmailHeader = RowComponent(
//       size: Vector2(1206 - 48, 30),
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         PositionComponent(
//           size: Vector2(150, 30),
//           children: [
//             TextComponent(
//               text: "Date:",
//               textRenderer: TextPaint(
//                 style: TextStyle(
//                   fontSize: 32,
//                   color: ThemeColors.checkServerStatusText,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         TextComponent(
//           text: dateEmail,
//           textRenderer: TextPaint(
//             style: TextStyle(fontSize: 32, color: Colors.white),
//           ),
//         ),
//       ],
//     );

//     RoundedRectangle innerEmailHeader = RoundedRectangle(
//       size: Vector2(1200, 134),
//       color: ThemeColors.mainContainerBg,
//       position: Vector2(3, 3),
//       radius: 8,
//       children: [
//         ColumnComponent(
//           size: Vector2(1200, 134),
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [fromEmailHeader, subjectEmailHeader, dateEmailHeader],
//         ),
//       ],
//     );

//     RoundedRectangle outerEmailHeader = RoundedRectangle(
//       size: Vector2(1206, 140),
//       color: ThemeColors.mainContainerOutline,
//       radius: 8,
//       children: [innerEmailHeader],
//     );

//     // EmailHeader emailHeader = EmailHeader(
//     //   fromEmail: "mircea@mircea.com",
//     //   subjectEmail: "Ceva ar trebui sa fie aici",
//     //   dateEmail: "15.03.2025 10:00",
//     // );
//     // ---

//     phishing = PhishingButton();
//     safe = SafeButton();

//     RoundedRectangle inner = RoundedRectangle(
//       size: Vector2(1206, 524),
//       color: ThemeColors.mainContainerBg,
//       position: Vector2(3, 3),
//       radius: 8,
//       children: [emailContent],
//     );

//     RoundedRectangle outer = RoundedRectangle(
//       size: Vector2(1212, 530),
//       color: ThemeColors.mainContainerOutline,
//       radius: 8,
//       children: [inner],
//     );

//     TextComponent text = TextComponent(
//       text: "Tap suspicious elements to highlight them",
//       textRenderer: TextPaint(
//         style: TextStyle(
//           fontSize: 24,
//           color: ThemeColors.checkServerStatusText,
//         ),
//       ),
//     );

//     RowComponent buttons = RowComponent(
//       size: Vector2(1920, 300),
//       position: Vector2(0, 850),
//       gap: 48,
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [safe, phishing],
//     );

//     ColumnComponent column = ColumnComponent(
//       size: Vector2(1500, 740),
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [outerEmailHeader, outer, text],
//     );

//     MainContainer mainContainer = MainContainer(child: column)
//       ..size = Vector2(1500, 740)
//       ..position = Vector2(210, 180);

//     add(mainContainer);
//     add(buttons);
//   }
// }
