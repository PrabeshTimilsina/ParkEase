import 'package:flutter/material.dart';
import 'package:park_ease/classes/nearby_parkings.dart';
import 'package:park_ease/presentation/components/nav_drawer.dart';
import 'package:park_ease/presentation/pages/booking.dart';

class parkingList extends StatelessWidget {
  parkingList({super.key, required this.nearbyParkings});

  final NearbyParkings? nearbyParkings;

  @override
  Widget build(BuildContext context) {
    Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Cannot book this parking spot'),
              content: const Text(
                  "There is a free parking sopt in this parking area but we don't Know for how long"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'))
              ],
            ));
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
                  final parkingAreaType = parkingArea.parkingAreaType;
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
                            Text('${parkingArea.distance} m'),
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

                        Row(
                          children: [
                            Text(
                                'Price: ${parkingArea.ratePerHour.toString()}/Hr',
                                style: const TextStyle(fontSize: 16)),
                            const Spacer(),
                            parkingAreaType == "regulated"
                                ? ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => Booking(
                                                  name: parkingArea.name,
                                                  rating: parkingArea.ratings,
                                                  distance:
                                                      parkingArea.distance,
                                                  rate: parkingArea
                                                      .ratePerHour)));
                                    },
                                    child: const Text('Book now'))
                                : ElevatedButton(
                                    onPressed: () {
                                      openDialog();
                                    },
                                    child: const Text('Unregulated'))
                          ],
                        ),

                        // Add more information as needed
                      ],
                    ),
                  );
                }));
  }
}
