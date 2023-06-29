// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:getgoods/src/pages/review/review_page.dart';
// import 'package:intl/intl.dart';

// import '../../../constants/colors.dart';

// class CompletedList extends StatefulWidget {
//   const CompletedList({super.key});

//   @override
//   State<CompletedList> createState() => _CompletedListState();
// }

// class _CompletedListState extends State<CompletedList> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: Column(
//         children: [
//           const SizedBox(height: 6),
//           _buildCompleted(
//             context: context,
//             shop: 'Trakasarn',
//             name: 'Product name',
//             order: '4567ujf38h833fh',
//             date: DateFormat.yMd().add_jm(),
//             amount: 2,
//             payment: 1000,
//           )
//         ],
//       ),
//     );
//   }
// }

// Container _buildCompleted({
//   required BuildContext context,
//   required String shop,
//   required String name,
//   required String order,
//   required DateFormat date,
//   required int amount,
//   required double payment,
// }) {
//   return Container(
//     decoration: BoxDecoration(
//       color: Colors.grey[200],
//       borderRadius: BorderRadius.circular(8),
//     ),
//     padding: EdgeInsets.all(10),
//     margin: EdgeInsets.only(bottom: 20),
//     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       const SizedBox(
//         width: 10,
//       ),
//       Text(
//         shop,
//         style: TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       SizedBox(height: 5),
//       Row(
//         children: [
//           SizedBox(
//             height: 48,
//             width: 48,
//             child: CachedNetworkImage(
//               imageUrl: 'https://picsum.photos/200/300',
//               fit: BoxFit.cover,
//               placeholder: (context, url) => const Center(
//                 child: CircularProgressIndicator(
//                   color: Colors.green,
//                 ),
//               ),
//               imageBuilder: (context, imageProvider) {
//                 return Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     image: DecorationImage(
//                       image: imageProvider,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 );
//               },
//               errorWidget: (context, url, error) {
//                 print(url);
//                 print(error);
//                 return const Center(
//                   child: Icon(
//                     Icons.error_outline,
//                     color: Colors.red,
//                     size: 40,
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(width: 5),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 name,
//                 style: const TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 'Order ID: $order',
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: secondaryTextColor,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 '$date',
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: secondaryTextColor,
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//       const SizedBox(height: 5),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'Amount: $amount',
//             style: const TextStyle(
//               fontSize: 13,
//               color: secondaryTextColor,
//             ),
//           ),
//           Text(
//             'Total payment: ฿$payment',
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.black,
//             ),
//           )
//         ],
//       ),
//       const SizedBox(height: 5),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           OutlinedButton(
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ReviewPage(),
//                   ));
//             },
//             style:
//                 OutlinedButton.styleFrom(side: BorderSide(color: Colors.green)),
//             child: Text(
//               'Review',
//               style: TextStyle(color: Colors.green),
//             ),
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           TextButton(
//             onPressed: () {},
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all(Colors.green),
//               foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//             ),
//             child: Text('Buy Again'),
//           )
//         ],
//       )
//     ]),
//   );
// }
