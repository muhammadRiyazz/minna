import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_data_event.freezed.dart';

@freezed
class HomeDataEvent with _$HomeDataEvent {
  const factory HomeDataEvent.fetchDestinations() = FetchDestinations;
  const factory HomeDataEvent.fetchVisaCountries() = FetchVisaCountries;
}
