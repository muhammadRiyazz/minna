import '../../domain/seatlayout/seatlayoutmodal.dart';

List<Seat> getLowerBerth({required List<Seat> seatsList}) {
  final List<Seat> lowerBerth = [];
  for (var seat in seatsList) {
    if (seat.zIndex == '0') {
      lowerBerth.add(seat);
    }
  }
  return lowerBerth;
}

List<Seat> getUpperBerth({required List<Seat> seatsList}) {
  final List<Seat> upperBerth = [];
  for (var seat in seatsList) {
    if (seat.zIndex == '1') {
      upperBerth.add(seat);
    }
  }
  return upperBerth;
}

int totalRow({required List<Seat> seatsList}) {
  int maxRow = 0;
  for (var seat in seatsList) {
    int row = int.parse(seat.row);
    if (row > maxRow) {
      maxRow = row;
    }
  }
  return maxRow;
}

int totalColumn({required List<Seat> seatsList}) {
  int maxColumn = 0;
  for (var seat in seatsList) {
    int column = int.parse(seat.column);
    if (column > maxColumn) {
      maxColumn = column;
    }
  }
  return maxColumn;
}
