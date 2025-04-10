// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:lottie/lottie.dart';
// import '../controllers/dashboard_controller.dart';

// class EditProductView extends StatelessWidget {
//   final int id;
//   final String name;
//   final String description;
//   final int price;

//   const EditProductView({
//     super.key,
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final DashboardController controller = Get.put(DashboardController());

//     // Isi controller-nya biar langsung muncul di form
//     controller.nameController.text = name;
//     controller.descriptionController.text = description;
//     controller.priceController.text = price.toString();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Produk'),
//         centerTitle: true,
//         backgroundColor: HexColor('#feeee8'),
//       ),
//       backgroundColor: HexColor('#feeee8'),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 30),
//             Lottie.network(
//               'https://gist.githubusercontent.com/olipiskandar/2095343e6b34255dcfb042166c4a3283/raw/d76e1121a2124640481edcf6e7712130304d6236/praujikom_kucing.json',
//               width: 150,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//               child: TextField(
//                 controller: controller.nameController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Product Name',
//                   hintText: 'Masukkan Nama Produk',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//               child: TextField(
//                 controller: controller.descriptionController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Description',
//                   hintText: 'Masukkan Deskripsi Produk',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//               child: TextField(
//                 controller: controller.priceController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Price',
//                   hintText: 'Masukkan Harga Produk',
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               height: 50,
//               width: 150,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: TextButton(
//                 onPressed: () {
//                   controller.editProduct(id: id);
//                 },
//                 child: const Text(
//                   'Save',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 25,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
