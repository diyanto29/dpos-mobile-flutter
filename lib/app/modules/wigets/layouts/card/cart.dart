//
//
// import 'package:flutter/material.dart';
//
// class CardOrders extends StatelessWidget {
//   final String orderNumber;
//   final String orderStatus;
//   final Color orderColorStatus;
//   final String orderDate;
//   final dynamic orderStore;
//   final String outlet;
//   final String totalOrders;
//   final String qtyOrders;
//   final Function orderClick;
//   final String cashier;
//   final bool showCashier;
//
//   const CardOrders({Key key, this.orderNumber, this.orderStatus, this.orderColorStatus, this.orderDate, this.orderStore, this.outlet, this.totalOrders, this.qtyOrders, this.orderClick, this.cashier, this.showCashier=false}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return  Card(
//       elevation: 2,
//       child: InkWell(
//         onTap: orderClick,
//         splashColor: Colors.grey,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment:
//                 MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Flexible(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 "Order#$orderNumber",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14),
//                               ),
//                               Icon(
//                                 Icons.arrow_forward_ios,
//                                 size: 15,
//                                 color: kPrimaryColor,
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 4,
//                           ),
//                           Text(
//                             "$orderDate",
//                             style: TextStyle(
//                                 color: Colors.grey, fontSize: 12),
//                           )
//                         ],
//                       )),
//                   Flexible(
//                     child: Container(
//                       alignment: Alignment.center,
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 6),
//                       decoration: BoxDecoration(
//                           borderRadius:
//                           BorderRadius.circular(5),
//                           color: orderColorStatus),
//                       child: Text(
//                         "$orderStatus",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               Divider(
//                 thickness: 1,
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               Row(
//                 mainAxisAlignment:
//                 MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Flexible(
//                       child: orderStore),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Flexible(
//                       flex: 3,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment:
//                             CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Toko Penjual",
//                                 style: TextStyle(
//                                     fontWeight:
//                                     FontWeight.bold),
//                               ),
//                               Text(
//                                 "$outlet",
//                                 style: TextStyle(
//                                     fontWeight:
//                                     FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10,),
//                           Row(
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment:
//                             CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Total Bayar",
//                                 style: TextStyle(
//                                     fontWeight:
//                                     FontWeight.bold),
//                               ),
//
//                               Text(
//                                 "$totalOrders",
//                                 style: TextStyle(
//                                     fontWeight:
//                                     FontWeight.bold),
//                               ),
//                             ],
//                           ),
//
//                           // Divider(thickness: 1,),
//                           SizedBox(height: 10,),
//                           Row(
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment:
//                             CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Jumlah yang dibeli",
//                                 style: TextStyle(
//                                     fontWeight:
//                                     FontWeight.bold),
//                               ),
//                               Text(
//                                 "$qtyOrders Produk",
//                                 style: TextStyle(
//                                     fontWeight:
//                                     FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ))
//                 ],
//               ),
//               showCashier? Divider(thickness: 1,) : Container(),
//               showCashier ? Text("Kasir :  $cashier") : Container()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
