import 'package:minna/bus/domain/Ticket%20details/ticket_details_more1.dart';

// totalfare({required List<InventoryItem> seats}) {
//   double totalfare = 0;
//   for (int i = 0; i < seats.length; i++) {
//     totalfare += double.parse(seats[i].fare);
//   }
//   return totalfare;
// }

num totalbasefare({required List<InventoryItem> seats}) {
  num total = 0;
  for (var element in seats) {
    total += double.tryParse(element.baseFare) ?? 0;
  }
  return total;
}

num totalfare({required List<InventoryItem> seats}) {
  num total = 0;
  for (var element in seats) {
    total += double.tryParse(element.fare) ?? 0;
  }
  return total;
}