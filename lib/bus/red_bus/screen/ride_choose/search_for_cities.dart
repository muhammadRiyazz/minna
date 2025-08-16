// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maaxusminihub/screen/red_bus/application/first_bloc/bloc/bloc/wallet_bloc_bloc.dart';
// import 'package:maaxusminihub/screen/red_bus/domain/data_post_redBus.dart';
// import 'package:searchfield/searchfield.dart';

// class ListSample extends StatelessWidget {
//   ListSample({Key? key}) : super(key: key);
//   String fromOrto = 'from';
//   @override
//   Widget build(BuildContext context) {
//     context.read<FirstBlocRedBus>().add(AllCitiesEvent());

//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           BlocBuilder<FirstBlocRedBus, WalletBlocState>(
//             builder: (context, state) {
//               if (state is AllCitiesState) {
//                 return CircularProgressIndicator();
//               }
//               if (state is AllCitiesNetworkErrorState) {
//                 return Text('${state.error}');
//               }
//               if (state is AllCitiesGotDataState) {
//                 return SearchField(
//                   onSuggestionTap: fromOrto == 'from'
//                       ? (e) {
//                           globalPostRedBus = globalPostRedBus.copyWith(
//                               idFromLocation: e.item.toString());
//                           print(e.item);

//                           print(globalPostRedBus.idFromLocation);
//                         }
//                       : (e) {
//                           globalPostRedBus = globalPostRedBus.copyWith(
//                               idToLocation: e.item.toString());
//                           print(e.item);
//                           print(globalPostRedBus.toLocation);
//                         },
//                   // controller: _controller,
//                   suggestionStyle: TextStyle(fontSize: 21),
//                   hint: " Search here",
//                   itemHeight: 41,
//                   textInputAction: TextInputAction.next,
//                   searchInputDecoration:
//                       InputDecoration(fillColor: Colors.blue),
//                   searchStyle: TextStyle(
//                     fontSize: 17,
//                     color: Colors.black.withOpacity(0.8),
//                   ),
//                   maxSuggestionsInViewPort: 21,
//                   suggestions: state.allCities.cities
//                       .map(
//                         (e) => SearchFieldListItem<String>(e!.name,
//                             child: Text(e.name), item: e.id.toString()),
//                       )
//                       .toList(),
//                 );
//               }
//               return Container();
//             },
//           ),
//           BlocBuilder<FirstBlocRedBus, WalletBlocState>(
//             builder: (context, state) {
//               if (state is AllCitiesState) {
//                 return CircularProgressIndicator();
//               }
//               if (state is AllCitiesNetworkErrorState) {
//                 return Text('${state.error}');
//               }
//               if (state is AllCitiesGotDataState) {
//                 return Container(
//                   width: double.infinity,
//                   height: 250,
//                   child: ListView.builder(
//                     itemCount: state.allCities.cities.length,
//                     itemBuilder: (c, i) {
//                       print(state.allCities.cities.length);
//                       return Column(
//                         children: [
//                           Text(state.allCities.cities[i]!.name),
//                         ],
//                       );
//                     },
//                   ),
//                 );
//               }
//               return Container();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
