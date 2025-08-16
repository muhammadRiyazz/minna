// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maaxusminihub/screen/red_bus/application/first_bloc/bloc/bloc/wallet_bloc_bloc.dart';

// class TestLayout extends StatelessWidget {
//   TestLayout({Key? key, required this.tripid}) : super(key: key);
//   String tripid;
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       context.read<FirstBlocRedBus>().add(SeatsAvailableEvent(tripIde: tripid));
//     });
//     return BlocBuilder<FirstBlocRedBus, WalletBlocState>(
//         builder: (context, state) {
//       if (state is GettingBusSeats) {
//         return Center(
//             child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(color: Colors.black),
//             TextButton(
//                 onPressed: () {
//                   context
//                       .read<FirstBlocRedBus>()
//                       .add(SeatsAvailableEvent(tripIde: tripid));
//                 },
//                 child: Text('Retry'))
//           ],
//         ));
//       }
//       if (state is NetworkErrorBusSeatState) {
//               return Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Center(
//                               child: TextButton(
//                                   onPressed: () {
//                                     context
//                                         .read<FirstBlocRedBus>()
//                                         .add(AvailableBudEvent());
//                                   },
//                                   child: Text(' Refresh ')),
//                             ),
//                           ],
//                         );
//       }
//       if (state is GotDataBusSeatState) {
//         return Scaffold(
//             appBar: AppBar(title: Text('Testing layout')),
//             body: ListView.builder(
//               // shrinkWrap: true,
//               itemCount: state.modelListofSeats.seats.length,
//               itemBuilder: (context, index1) {
//                 //row ->
//                 //col !

//                 // in index 1 that is this is first row
//                 if (num.parse(state.modelListofSeats.seats[index1].zIndex) == 0)
//                   return Text(
//                       '${state.modelListofSeats.seats[index1].row},${state.modelListofSeats.seats[index1].column}   -   ');

//                 //   return ListView.builder(
//                 //     shrinkWrap: true,
//                 //     scrollDirection: Axis.horizontal,
//                 //     itemCount: 10,
//                 //     itemBuilder: (context, index2) {},
//                 //   );
//               },
//             ));
//       }
//       return Scaffold(
//         appBar: AppBar(),
//         body: Container(
//           child: Center(
//             child: TextButton(
//                 onPressed: () {
//                   context
//                       .read<FirstBlocRedBus>()
//                       .add(SeatsAvailableEvent(tripIde: tripid));
//                 },
//                 child: Text('Retry')),
//           ),
//         ),
//       );
//     });
//   }
// }
