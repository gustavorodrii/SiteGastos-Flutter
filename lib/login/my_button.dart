// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';

// class MyButton extends StatelessWidget {
//   final Function()? onPressed;
//   final String text;
//   const MyButton({
//     Key? key,
//     required this.onPressed,
//     required this.text,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 25),
//       child: SizedBox(
//         width: size.width,
//         height: 50,
//         child: ElevatedButton(
//           onPressed: onPressed,
//           child: Text(
//             text,
//             style: const TextStyle(fontSize: 26),
//           ),
//         ),
//       ),
//     );
//   }
// }
