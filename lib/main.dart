import 'dart:math';

import 'package:ev_charging/firebase_options.dart';
import 'package:ev_charging/src/features/authentication/screens/welcome.dart';
import 'package:ev_charging/src/repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ev_charging/src/utils/theme/theme.dart';
import 'package:ev_charging/src/features/authentication/screens/mapscreen.dart';
import 'package:latlong2/latlong.dart';



//import 'package:ev_charging/src/features/authentication/screens/login.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value)=> Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const WelcomePage(),
    );
  }
}

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: Text(
          'EV Charging Station App',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthenticationRepository.instance.logOut();
              Get.offAll(() => const WelcomePage());
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Full-width image
          Image.asset(
            'assets/images/login.png',
            fit: BoxFit.cover,
            height: 200,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to the EV Charging Station App!',
                    style: GoogleFonts.lato(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MapScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent, // Button color
                      foregroundColor: Colors.white, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: Text(
                      'Find Charging Stations',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PaymentPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent, // Button color
                      foregroundColor: Colors.black, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: Text(
                      'Manage Payments',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
    );
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  final List<Map<String, dynamic>> locations = const [
    {
      'name': 'Ahmedabad Charging Station',
      'latitude': 23.0225,
      'longitude': 72.5714,
      'info': 'Fast charging available',
      'image': 'assets/images/gandhinagar_station.jpg',

    },
    {
      'name': 'Surat Charging Station',
      'latitude': 21.1702,
      'longitude': 72.8311,
      'info': '24/7 service',
      'image': 'assets/images/Designer.png',

    },
    {
      'name': 'Vadodara Charging Station',
      'latitude': 22.3072,
      'longitude': 73.1812,
      'info': 'Free parking',
      'image': 'assets/images/gandhinagar_station.jpg',

    },
    {
      'name': 'Gandhinagar Charging Station',
      'latitude': 23.2156,
      'longitude': 72.6369,
      'info': 'Solar-powered charging',
      'image': 'assets/images/gandhinagar_station.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EV Charging Stations'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(23.0225, 72.5714),
          zoom: 10.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            additionalOptions: const {
              'attribution': '© OpenStreetMap contributors',
            },
          ),
          MarkerLayer(
            markers: locations.map((location) {
              return Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(location['latitude'], location['longitude']),
                builder: (ctx) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      ctx,
                      MaterialPageRoute(
                        builder: (context) => BookingPage(station: location),
                      ),
                    );
                  },
                  child: Tooltip(
                    message: location['info'],
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 45.0,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
class BookingPage extends StatefulWidget {
  final Map<String, dynamic> station;

  const BookingPage({required this.station, super.key});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  TimeOfDay? _selectedTime;
  String? _batteryType;
  int? _batteryWattage;
  bool _fastCharge = false;
  bool _playArea = false;
  final int _costPerWatt = 10; // Cost per wattage unit
  final int _fastChargeCost = 50; // Additional cost for fast charge
  final int _playAreaCost = 20; // Additional cost for play area

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  int _calculateTotalAmount() {
    int amount = (_batteryWattage ?? 0) * _costPerWatt;
    if (_fastCharge) amount += _fastChargeCost;
    if (_playArea) amount += _playAreaCost;
    return amount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Slot at ${widget.station['name']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Station Info: ${widget.station['info']}'),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedTime != null
                          ? 'Selected Time: ${_selectedTime!.format(context)}'
                          : 'Select Time Slot',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.access_time),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _batteryType,
              hint: const Text('Select Battery Type'),
              items: ['Lithium-ion', 'Nickel-metal hydride', 'Lead-acid', 'Solid-state']
                  .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _batteryType = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Enter Battery Wattage',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _batteryWattage = int.tryParse(value);
                });
              },
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text('Fast Charge'),
              value: _fastCharge,
              onChanged: (value) {
                setState(() {
                  _fastCharge = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Play Area'),
              value: _playArea,
              onChanged: (value) {
                setState(() {
                  _playArea = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_selectedTime != null && _batteryType != null && _batteryWattage != null) {
                  final totalAmount = _calculateTotalAmount();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                        station: widget.station,
                        selectedTime: _selectedTime!,
                        batteryType: _batteryType!,
                        batteryWattage: _batteryWattage!,
                        fastCharge: _fastCharge,
                        playArea: _playArea,
                        totalAmount: totalAmount,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please complete all fields.'),
                    ),
                  );
                }
              },
              child: const Text('Calculate and Book Now'),
            ),
          ],
        ),
      ),
    );
  }
}
class PaymentScreen extends StatelessWidget {
  final Map<String, dynamic> station;
  final TimeOfDay selectedTime;
  final String batteryType;
  final int batteryWattage;
  final bool fastCharge;
  final bool playArea;
  final int totalAmount;

  const PaymentScreen({
    required this.station,
    required this.selectedTime,
    required this.batteryType,
    required this.batteryWattage,
    required this.fastCharge,
    required this.playArea,
    required this.totalAmount,
    super.key,
  });

  // Method to generate a unique token
  String _generateToken() {
    final random = Random();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(8, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  // Method to store the token with the selected time and manage its status
  void _storeToken(String token, TimeOfDay time, BuildContext context) {
    // You can use a database or a local storage method like SharedPreferences
    // For now, we're just printing it out as a placeholder
    print('Token generated: $token');
    print('Selected time: ${time.format(context)}');

    // This is where you'd manage the token's active status and 24-hour expiry
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Confirm your booking at ${station['name']}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Selected Time: ${selectedTime.format(context)}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Battery Type: $batteryType',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Battery Wattage: $batteryWattage',
              style: const TextStyle(fontSize: 16),
            ),
            if (fastCharge)
              const Text(
                'Service: Fast Charge',
                style: TextStyle(fontSize: 16),
              ),
            if (playArea)
              const Text(
                'Service: Play Area',
                style: TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 20),
            Text(
              'Total Amount: \$${totalAmount.toString()}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final token = _generateToken();
                _storeToken(token, selectedTime, context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationScreen(token: token),
                  ),
                );
              },
              child: const Text('Pay with UPI'),
            ),
            ElevatedButton(
              onPressed: () {
                final token = _generateToken();
                _storeToken(token, selectedTime, context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationScreen(token: token),
                  ),
                );
              },
              child: const Text('Pay with Card'),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmationScreen extends StatelessWidget {
  final String token;

  const ConfirmationScreen({required this.token, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 20),
            Text(
              'Your booking is confirmed!',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Your Token: $token',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Please use this token to charge your vehicle at the selected time.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                //Navigator.popUntil(context, ModalRoute.withName('/'));
                Get.offAll(() => const AppHome());
              },
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}




