// import 'package:bloc/bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// import '../../../domain/free/freezed/frezzed.dart';
// import '../../../infrastructure/show_ticket.dart';

// part 'freezed_bloc_event.dart';
// part 'freezed_bloc_state.dart';
// part 'freezed_bloc_bloc.freezed.dart';

// // class FreezedBlocBloc extends Bloc<FreezedBlocEvent, FreezedBlocState> {
// //   FreezedBlocBloc() : super(FreezedBlocState.initial()) {
// //     on<_GetTicketDetails>((event, emit) {
// //       emit(state.copyWith( isLoading: true));
// //       // TODO: implement event handler
// //       // emit(state.copyWith(error: 'error'));
      
// //       // emit(state.copyWith(freezModel: ));
// //       var _res = TicketShowClass().getDataTicketShow(tIn: 'sdf');

      

// //     });
// //   }
// // }

// // class FareRileBloc extends Bloc<FareRileEvent, FareRileState> {
// //   FareRileBloc() : super(FareRileState.initial()) {
// //     on<_GetFareRule>((event, emit) async {
// //       emit(state.copyWith(isLoading: true));
// //       String res = await FareRuleRequest.getFareRule(
// //           itinenaryId: event.iteId, token: event.token);
// //       String data = jsonDecode(res)['FareRule'] ?? '';
// //       emit(state.copyWith(isLoading: false, data: data));
// //     });
// //   }
// // }
