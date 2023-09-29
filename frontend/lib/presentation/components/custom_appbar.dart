import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:park_ease/presentation/pages/location_selection.dart';
import 'package:park_ease/presentation/components/location_picker.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({super.key, required this.customTitle});

  final String customTitle;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.customTitle),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showSearch(context: context, delegate: MySearchDelegate());
          },
        )
      ],
      centerTitle: true,
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  // avoid submission on enter
  MySearchDelegate({super.textInputAction = TextInputAction.none});

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    developer.log("Received point: $query");
    final GeoPoint point = GeoPoint(
        latitude: double.parse(query.split(",").first),
        longitude: double.parse(query.split(",").last));

    return Center(child: LocationPicker(initialLocation: point));
  }

  Future<List<SearchInfo>> _addressSuggestion(String query) async {
    return addressSuggestion(query);
  }

  Future<List<SearchInfo>> _getDefaultSuggestions(String query) async {
    return List<SearchInfo>.empty();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: query.length > 3
            ? _addressSuggestion(query)
            : _getDefaultSuggestions(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<SearchInfo>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<SearchInfo> searchInfos;
            if ((snapshot.data != null) && snapshot.hasData) {
              searchInfos = snapshot.data as List<SearchInfo>;
            } else {
              searchInfos = List<SearchInfo>.empty();
            }

            List<String> addressNames = searchInfos.map((searchInfo) {
              return searchInfo.address.toString();
            }).toList();

            final Iterable<String> suggestions = addressNames;

            return ListView.builder(
              itemExtent: 50.0,
              itemBuilder: (ctx, index) {
                return ListTile(
                    title: Text(
                      suggestions.elementAt(index),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                    onTap: () {
                      // serializing the point
                      // developer.log(
                      //     "Sent point: GeoPoint{ latitude: ${searchInfos[index].point!.latitude}, longitude: ${searchInfos[index].point!.latitude}}");
                      // query = "${searchInfos[index].point!.latitude},${searchInfos[index].point!.longitude}";
                      // buildResults(context);

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LocationSelection(
                                initialLocation: searchInfos[index].point,
                                initialAddress:
                                    searchInfos[index].address.toString(),
                              )));
                    });
              },
              itemCount: snapshot.data!.length,
            );
          } else {
            return ListView();
          }
        });
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: const Icon(Icons.clear))
      ];
}
