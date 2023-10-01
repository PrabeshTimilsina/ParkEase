import 'package:flutter/material.dart';
import 'package:park_ease/presentation/components/my_button.dart';
import 'package:park_ease/presentation/components/my_textfield.dart';
import 'package:park_ease/presentation/components/nav_drawer.dart';
import 'package:park_ease/presentation/components/square_tile.dart';

class Booking extends StatefulWidget {
  const Booking(
      {Key? key,
      required this.name,
      required this.rating,
      required this.distance,
      required this.rate})
      : super(key: key);

  final String name;
  final double rating;
  final double distance;
  final int rate;

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final hourController = TextEditingController();
  double total = 0.0; // Variable to store the total value

  @override
  void dispose() {
    hourController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Book Now")),
      drawer: const NavDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.80,
                height: MediaQuery.of(context).size.height * 0.33,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 11, 19, 30),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.rating.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.white,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${widget.distance.toString()} m',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(
                            isselected: false,
                            imageLocation: 'assets/images/car.jpg'),
                        SizedBox(
                          width: 50,
                        ),
                        SquareTile(
                            isselected: false,
                            imageLocation: 'assets/images/bike.jpg'),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: 130,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 11, 19, 30),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Rate: ${widget.rate}/hrs',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: hourController,
                hintText: 'For(in hours): ',
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: Container(
                  width: 130,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 11, 19, 30),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Total: $total', // Display the total value
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              MyButton(
                onTap: () {
                  final int rate = widget.rate;

                  final double hours =
                      double.tryParse(hourController.text) ?? 0.0;
                  setState(() {
                    total = rate * hours;
                  });
                },
                buttonName: "Book",
              ),
              const SizedBox(height: 10),
              MyButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  buttonName: 'Cancel'),
            ],
          ),
        ),
      ),
    );
  }
}
