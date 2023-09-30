import 'package:flutter/material.dart';
import 'package:park_ease/classes/nearby_parkings.dart';
import 'package:park_ease/presentation/components/nav_drawer.dart';
import 'package:park_ease/presentation/pages/booking.dart';

class parkingList extends StatelessWidget {
  parkingList({super.key, required this.nearbyParkings});

  final NearbyParkings? nearbyParkings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: const Center(child: Text("Parking List")),
        ),
        body: (nearbyParkings == null ||
                nearbyParkings!.nearbyParkingAreas == null)
            ? const Center(child: Text("Didn't find any parking areas."))
            : ListView.builder(
                itemCount: (nearbyParkings != null)
                    ? ((nearbyParkings!.nearbyParkingAreas != null)
                        ? nearbyParkings!.nearbyParkingAreas!.length
                        : 0)
                    : 0,
                itemBuilder: (context, index) {
                  if (nearbyParkings == null ||
                      nearbyParkings!.nearbyParkingAreas == null) {
                    return const Center(
                        child: Text("Didn't find any parking areas."));
                  }
                  final parkingArea =
                      nearbyParkings!.nearbyParkingAreas![index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8),
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              parkingArea.name,
                              style: const TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Text('${parkingArea.latitude} distance'),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text('Rating: ${parkingArea.ratings.toString()}/5 ',
                                style: const TextStyle(fontSize: 16)),
                            const Icon(Icons.star),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('Price: ${parkingArea.ratePerHour.toString()}/Hr',
                            style: const TextStyle(fontSize: 16)),
                        Row(
                          children: [
                            Text(' ${parkingArea.longitude} address',
                                style: const TextStyle(fontSize: 16)),
                            const Spacer(),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Booking(
                                          name: parkingArea.name,
                                          rating: parkingArea.ratings,
                                          distance: parkingArea.latitude,
                                          rate: parkingArea.ratePerHour)));
                                },
                                child: const Text('Book now'))
                          ],
                        ),

                        // Add more information as needed
                      ],
                    ),
                  );
                }));
  }
}
