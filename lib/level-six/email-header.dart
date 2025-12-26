// import 'package:flame/components.dart';
// import 'package:flame/experimental.dart' hide RoundedRectangle;
// import 'package:flutter/material.dart';
// import 'package:hack_improved/components/rounded_rectangle.dart';
// import 'package:hack_improved/constants.dart';

// class EmailHeader extends PositionComponent {
//   String fromEmail;
//   String subjectEmail;
//   String dateEmail;

//   EmailHeader({
//     required this.fromEmail,
//     required this.subjectEmail,
//     required this.dateEmail,
//   }) : super(size: Vector2(1206, 134));

//   @override
//   Future<void> onLoad() async {
//     RowComponent from = RowComponent(
//       size: Vector2(size.x - 48, 30),
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
//         TextComponent(
//           text: fromEmail,
//           textRenderer: TextPaint(
//             style: TextStyle(fontSize: 32, color: Colors.white),
//           ),
//         ),
//       ],
//     );

//     RowComponent subject = RowComponent(
//       size: Vector2(size.x - 48, 30),
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

//     RowComponent date = RowComponent(
//       size: Vector2(size.x - 48, 30),
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

//     RoundedRectangle inner = RoundedRectangle(
//       size: Vector2(1200, 134),
//       color: ThemeColors.mainContainerBg,
//       position: Vector2(3, 3),
//       radius: 8,
//       children: [
//         ColumnComponent(
//           size: Vector2(1200, 134),
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [from, subject, date],
//         ),
//       ],
//     );

//     RoundedRectangle outer = RoundedRectangle(
//       size: Vector2(1206, 140),
//       color: ThemeColors.mainContainerOutline,
//       radius: 8,
//       children: [inner],
//     );
//     add(outer);
//   }
// }
