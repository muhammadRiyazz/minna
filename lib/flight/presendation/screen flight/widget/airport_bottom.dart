import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/flight/application/search%20data/search_data_bloc.dart';
import 'package:minna/flight/presendation/screen%20flight/widget/loading.dart' show buildShimmerLoading;

void showAirportBottomSheet(BuildContext context, {required bool isFrom}) {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  // Clear previous search results on entry
  context.read<SearchDataBloc>().add(const SearchDataEvent.clearSearchAirports());

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            // Handle and Header
            Container(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isFrom ? 'Flying From' : 'Flying To',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.close_rounded, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar Area
            Container(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: TextField(
                controller: searchController,
                focusNode: searchFocusNode,
                autofocus: true,
                style: const TextStyle(fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: 'Search city or airport...',
                  hintStyle: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.w400),
                  prefixIcon: Icon(Icons.search_rounded, color: Colors.grey[600]),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  suffixIcon: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: searchController,
                    builder: (context, value, _) {
                      return value.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.cancel_rounded, size: 20),
                              onPressed: () {
                                searchController.clear();
                                context.read<SearchDataBloc>().add(
                                  const SearchDataEvent.getAirports(searchKey: ''),
                                );
                              },
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                ),
                onChanged: (value) {
                  context.read<SearchDataBloc>().add(
                    SearchDataEvent.getAirports(searchKey: value),
                  );
                },
              ),
            ),

            const Divider(height: 1),

            // Results List
            Expanded(
              child: BlocBuilder<SearchDataBloc, SearchDataState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount: 5,
                      itemBuilder: (context, _) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Container(width: 48, height: 48, decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12))),
                            const SizedBox(width: 16),
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Container(width: 120, height: 16, color: Colors.grey[50]),
                              const SizedBox(height: 8),
                              Container(width: 200, height: 12, color: Colors.grey[50]),
                            ])),
                          ],
                        ),
                      ),
                    );
                  }

                  if (state.airports.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            searchController.text.isEmpty ? Icons.flight_takeoff_rounded : Icons.search_off_rounded,
                            size: 64,
                            color: Colors.grey[200],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            searchController.text.isEmpty
                                ? 'Where are you going?'
                                : 'No matches found',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            searchController.text.isEmpty
                                ? 'Search by city name or airport code'
                                : 'Try searching for another city or code',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: state.airports.length,
                    itemBuilder: (context, index) {
                      final airport = state.airports[index];
                      return InkWell(
                        onTap: () {
                          context.read<SearchDataBloc>().add(
                            SearchDataEvent.fromOrTo(
                              fromOrTo: isFrom ? 'from' : 'to',
                              airport: airport,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD4AF37).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(Icons.flight_rounded, color: Color(0xFFD4AF37)),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          airport.code,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            airport.type == 'I' ? 'INTL' : 'DOM',
                                            style: TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      airport.name,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      airport.countryCode,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

