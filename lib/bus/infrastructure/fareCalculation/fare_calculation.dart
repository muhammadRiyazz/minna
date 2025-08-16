import 'package:minna/bus/domain/Ticket%20details/ticket_details_more1.dart';

totalfare({required List<InventoryItem> seats}) {
  double totalfare = 0;
  for (int i = 0; i < seats.length; i++) {
    totalfare += double.parse(seats[i].fare);
  }
  return totalfare;
}

totalbasefare({required List seats}) {
  double totalbasefare = 0;
  for (int i = 0; i < seats.length; i++) {
    totalbasefare += double.parse(seats[i].baseFare);
  }
  return totalbasefare;
}
