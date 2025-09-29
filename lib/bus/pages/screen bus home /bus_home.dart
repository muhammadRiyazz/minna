import 'package:minna/bus/application/busListfetch/bus_list_fetch_bloc.dart';
import 'package:minna/bus/application/change%20location/location_bloc.dart';
import 'package:minna/bus/domain/location/location_modal.dart';
import 'package:minna/bus/pages/Screen%20available%20Trip/screen_available_triplist.dart';
import 'package:minna/bus/pages/search%20location%20screen/search_location_screen.dart';
import 'package:minna/comman/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BusHomeTab extends StatelessWidget {
  const BusHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Bus Booking',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: maincolor1,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                // color: Colors.amberAccent,
                height: 190,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset('asset/bus/busn.png', fit: BoxFit.fill),
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Bus Tickets',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      'Book your bus tickets easily and securely',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 25),
                    _LocationSelector(),
                    const SizedBox(height: 15),
                    _SearchButton(),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _LocationTile(
                    label: 'From',
                    location: state.from,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) =>
                            LocationSearchPage(fromOrto: 'from'),
                      );
                    },
                    placeholderText: 'Select departure',
                  ),
                  const Divider(height: 0),
                  _LocationTile(
                    label: 'To',
                    location: state.to,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) =>
                            LocationSearchPage(fromOrto: 'to'),
                      );
                    },
                    placeholderText: 'Select destination',
                  ),
                  const Divider(height: 0),
                  const SizedBox(height: 15),
                  _DatePicker(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Positioned(
              top: 43,
              right: 25,
              child: IconButton(
                icon: Icon(
                  Icons.swap_vert_circle,
                  size: 40,
                  color: maincolor1!,
                ),
                onPressed: () =>
                    context.read<LocationBloc>().add(SwapLocations()),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LocationTile extends StatelessWidget {
  final String label;
  final City? location;
  final VoidCallback onTap;
  final String placeholderText;

  const _LocationTile({
    required this.label,
    required this.location,
    required this.onTap,
    this.placeholderText = 'Please select',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 4),
        title: Text(
          label,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
        subtitle: Text(
          location?.name ?? placeholderText,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        leading: Icon(
          Icons.directions_bus_outlined,
          color: maincolor1!,
          size: 30,
        ),
      ),
    );
  }
}

class _DatePicker extends StatefulWidget {
  @override
  __DatePickerState createState() => __DatePickerState();
}

class __DatePickerState extends State<_DatePicker> {
  bool _isTodaySelected = false;
  bool _isTomorrowSelected = false;

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: maincolor1!,
            onPrimary: Colors.white,
            onSurface: maincolor1!,
          ),
        ),
        child: child!,
      ),
    );

    if (pickedDate != null) {
      context.read<LocationBloc>().add(UpdateDate(date: pickedDate));
      setState(() {
        _isTodaySelected = false;
        _isTomorrowSelected = false;
      });
    }
  }

  void _selectToday() {
    final today = DateTime.now();
    context.read<LocationBloc>().add(UpdateDate(date: today));
    setState(() {
      _isTodaySelected = true;
      _isTomorrowSelected = false;
    });
  }

  void _selectTomorrow() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    context.read<LocationBloc>().add(UpdateDate(date: tomorrow));
    setState(() {
      _isTodaySelected = false;
      _isTomorrowSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: _pickDate,
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: maincolor1!,
                      size: 32,
                    ),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 2),
                        const Text(
                          "Date of Journey",
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          DateFormat('d MMMM yyyy').format(state.dateOfJourney),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  _DateChipButton("Today", _isTodaySelected, _selectToday),
                  const SizedBox(width: 8),
                  _DateChipButton(
                    "Tomorrow",
                    _isTomorrowSelected,
                    _selectTomorrow,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DateChipButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DateChipButton(this.label, this.isSelected, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? maincolor1! : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return SizedBox(
          height: 50,
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              if (state.from == null || state.to == null) {
                _showLocationErrorSnackbar(context);
                return;
              }

              BlocProvider.of<BusListFetchBloc>(context).add(
                FetchTrip(
                  dateOfjurny: state.dateOfJourney,
                  destID: state.to!,
                  sourceID: state.from!,
                ),
              );

              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ScreenAvailableTrips()),
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: maincolor1!,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 2,
              shadowColor: Colors.black.withOpacity(0.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.directions_bus, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'SEARCH BUSES',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLocationErrorSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(16),
        backgroundColor: Colors.red[400],
        content: Row(
          children: [
            Icon(Icons.location_on, color: Colors.white, size: 24),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Location Missing',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Please select both departure and destination',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
