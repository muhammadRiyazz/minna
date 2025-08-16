import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';
import 'package:minna/bus/domain/location/location_modal.dart';
import 'package:minna/bus/infrastructure/fetch%20locations/fetch_location_list.dart';

part 'bus_location_fetch_event.dart';
part 'bus_location_fetch_state.dart';
part 'bus_location_fetch_bloc.freezed.dart';

class BusLocationFetchBloc extends Bloc<BusLocationFetchEvent, BusLocationFetchState> {
  BusLocationFetchBloc() : super(BusLocationFetchState.initial()) {
on<GetData>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      try {
        if (state.allCitydata == null) {
          final Response respo = await locationData();
          final String body = respo.body.trim();

          if (respo.statusCode == 200 &&
              !body.contains('Authorization failed')) {
            final CityModelList locationList = cityModelDataFromJson(body);
            emit(
              state.copyWith(
                isLoading: false,
                allCitydata: locationList,
                filteredCities: locationList.cities,
              ),
            );
          } else {
            emit(state.copyWith(isLoading: false));
          }
        } else {
          emit(state.copyWith(isLoading: false));
        }
      } catch (e) {
        emit(state.copyWith(isLoading: false));
      }
    });

    on<SearchLocations>((event, emit) {
      if (state.allCitydata == null) return;

      final query = event.query.trim().toLowerCase(); // Added trim() here
      final filtered =
          state.allCitydata!.cities.where((city) {
            final cityName = city.name.toLowerCase();
            final stateName = city.state.toLowerCase();
            return cityName.contains(query) || stateName.contains(query);
          }).toList();

      emit(state.copyWith(filteredCities: filtered));
    });
  }
}
