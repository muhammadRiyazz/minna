import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/flight/application/search%20data/search_data_bloc.dart';
import 'package:minna/flight/presendation/screen%20flight/widget/loading.dart'
    show buildShimmerLoading;

void showAirportBottomSheet(BuildContext context, {required bool isFrom}) {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  context.read<SearchDataBloc>().add(
    const SearchDataEvent.clearSearchAirports(),
  );

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 40,
              offset: const Offset(0, -10),
            ),
          ],
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
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: secondaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Iconsax.airplane,
                            color: secondaryColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isFrom ? 'Flying From' : 'Flying To',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: maincolor1,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              Text(
                                isFrom
                                    ? 'Select your origin'
                                    : 'Select your destination',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: textSecondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close_rounded,
                              color: textSecondary,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Modern Search Bar
            Container(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: TextField(
                controller: searchController,
                focusNode: searchFocusNode,
                autofocus: true,
                style: TextStyle(
                  fontSize: 14,
                  color: textPrimary,
                  fontWeight: FontWeight.w700,
                ),
                decoration: InputDecoration(
                  hintText: 'Search city or airport...',
                  hintStyle: TextStyle(
                    color: textLight.withOpacity(0.6),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(
                    Iconsax.search_normal_1,
                    color: secondaryColor,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.05),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(
                      color: secondaryColor.withOpacity(0.1),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  suffixIcon: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: searchController,
                    builder: (context, value, _) {
                      return value.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Iconsax.close_circle5,
                                color: textLight.withOpacity(0.5),
                                size: 20,
                              ),
                              onPressed: () {
                                searchController.clear();
                                context.read<SearchDataBloc>().add(
                                  const SearchDataEvent.getAirports(
                                    searchKey: '',
                                  ),
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
                    return _buildModernLoading();
                  }

                  if (state.airports.isEmpty) {
                    return _buildModernEmptyState(searchController.text);
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.airports.length,
                    itemBuilder: (context, index) {
                      final airport = state.airports[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.01),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
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
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          maincolor1.withOpacity(0.05),
                                          maincolor1.withOpacity(0.1),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(
                                      Iconsax.airplane,
                                      color: maincolor1,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              airport.code,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 13,
                                                color: maincolor1,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: secondaryColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                airport.type == 'I'
                                                    ? 'INTL'
                                                    : 'DOM',
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w900,
                                                  color: secondaryColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          airport.name,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: maincolor1,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.2,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          airport.countryCode,
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: textSecondary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Iconsax.arrow_right_3,
                                    color: maincolor1.withOpacity(0.3),
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
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

Widget _buildModernLoading() {
  return ListView.builder(
    padding: const EdgeInsets.all(20),
    itemCount: 6,
    itemBuilder: (context, _) => Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: 72,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: buildShimmerLoading(),
    ),
  );
}

Widget _buildModernEmptyState(String query) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: secondaryColor.withOpacity(0.05),
            shape: BoxShape.circle,
          ),
          child: Icon(
            query.isEmpty ? Iconsax.airplane : Iconsax.search_status,
            size: 56,
            color: secondaryColor.withOpacity(0.35),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          query.isEmpty ? 'Where are you going?' : 'No Matches Found',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
            color: maincolor1,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            query.isEmpty
                ? 'Search by city name or airport code to find your flight'
                : 'We couldn\'t find any airports matching "$query"',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: textSecondary,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}
