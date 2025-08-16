import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/flight/application/search%20data/search_data_bloc.dart';
import 'package:minna/flight/presendation/screen%20flight/widget/loading.dart' show buildShimmerLoading;

void showAirportBottomSheet(BuildContext context, {required bool isFrom}) {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isFrom ? 'Select Departure' : 'Select Arrival',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: searchController,
                  focusNode: searchFocusNode,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search airport or city',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    context.read<SearchDataBloc>().add(
                      SearchDataEvent.getAirports(searchKey: value),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              // Content
              Expanded(
                child: BlocBuilder<SearchDataBloc, SearchDataState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return buildShimmerLoading();
                    }
                    if (state.airports.isEmpty) {
                      return Center(
                        child: Text(
                          searchController.text.isEmpty
                              ? 'Start typing to search airports'
                              : 'No airports found',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.airports.length,
                      itemBuilder: (context, index) {
                        final airport = state.airports[index];
                        return ListTile(
                          leading: Icon(Icons.flight, color: maincolor1!),
                          title: Text(airport.name),
                          subtitle: Text(
                            '${airport.code} • ${airport.type}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          onTap: () {
                            context.read<SearchDataBloc>().add(
                              SearchDataEvent.fromOrTo(
                                fromOrTo: isFrom ? 'from' : 'to',
                                airport: airport,
                              ),
                            );
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

