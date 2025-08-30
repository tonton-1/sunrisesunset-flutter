import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'suntime.dart';
import 'apiservice.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

List<SunTimes?> listData = List.filled(6, null);

class _HomepageState extends State<Homepage> {
  late SunTimes sunriseSunsetData;
  late SunTimes ListDataContainer;
  @override
  void initState() {
    tz.initializeTimeZones();
    super.initState();
    sunriseSunsetData = SunTimes();
    ListDataContainer = SunTimes();
    loadData();
    loadAllListData();
  }

  List<Map<String, String>> items = [
    {'city': 'Chiangmai', 'lat': '18.777806', 'lng': '98.995495'},
    {'city': 'Bangkok', 'lat': '13.756331', 'lng': '100.501762'},
    {'city': 'Phuket', 'lat': '7.880448', 'lng': '98.392300'},
    {'city': 'Hat Yai', 'lat': '7.008911', 'lng': '100.474610'},
    {'city': 'Khon Kaen', 'lat': '16.441891', 'lng': '102.835000'},
    {'city': 'Udon Thani', 'lat': '17.364720', 'lng': '102.815000'},
  ];
  void loadAllListData() async {
    for (int i = 0; i < items.length; i++) {
      double lat = double.parse(items[i]['lat']!);
      double lng = double.parse(items[i]['lng']!);
      final data = await ApiService().fetchSunriseSunset(
        mylocationlat: lat,
        mylocationlng: lng,
      );
      setState(() {
        listData[i] = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(
      sunriseSunsetData.results?.date ?? 'Loading...',
    );
    String formattedDate = DateFormat("d MMMM yyyy").format(dateTime);
    String dayName = DateFormat('EEEE').format(dateTime);
    // กำหนด timezone ที่ต้องการ เช่น London
    final london = tz.getLocation('Europe/London');
    final ny = tz.getLocation('America/New_York');
    final bangkok = tz.getLocation('Asia/Bangkok');

    // เวลาปัจจุบันของแต่ละประเทศ
    final nowLondon = tz.TZDateTime.now(london);
    final nowNY = tz.TZDateTime.now(ny);
    final nowBKK = tz.TZDateTime.now(bangkok);

    print('London: $nowLondon'); // 👉 เวลา London
    print('New York: $nowNY'); // 👉 เวลา New York
    print('Bangkok: $nowBKK'); // 👉 เวลา กรุงเทพฯ

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),

      body: Container(
        color: const Color.fromARGB(136, 228, 228, 228),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          spacing: 13,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Container(
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(20),

              child: Column(
                // หลัก
                spacing: 13,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 25,
                    children: [
                      Column(
                        spacing: 10,
                        children: [
                          Image.asset(
                            'assets/images/sunrise.png',
                            width: 80,
                            height: 80,
                          ),
                          Text(
                            '${sunriseSunsetData.results?.sunrise ?? 'Loading...'}',
                            style: GoogleFonts.kanit(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: 10,
                        children: [
                          Image.asset(
                            'assets/images/sunset.png',
                            width: 80,
                            height: 80,
                          ),
                          Text(
                            '${sunriseSunsetData.results?.sunset ?? 'Loading...'}',
                            style: GoogleFonts.kanit(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$dayName,",
                        style: GoogleFonts.kanit(
                          fontSize: 21,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        " $formattedDate",
                        style: GoogleFonts.kanit(fontSize: 21),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Color.fromARGB(255, 224, 79, 27),
                      ),

                      Text(
                        'Nakhon Pathom',
                        style: GoogleFonts.kanit(
                          fontSize: 17,
                          wordSpacing: 1,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              height: 600,
              width: 400,
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  final city = items[index]['city'];
                  final sunrise =
                      listData[index]?.results?.sunrise ?? 'Loading...';
                  final sunset =
                      listData[index]?.results?.sunset ?? 'Loading...';
                  return Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),

                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),

                    height: 80,
                    width: 400,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Text(
                          city ?? 'Loading...',
                          style: GoogleFonts.kanit(fontSize: 16),
                        ),

                        Spacer(),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 0,
                          ),
                          child: Row(
                            spacing: 25,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.north),
                                  Text(
                                    sunrise,
                                    style: GoogleFonts.kanit(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.south),
                                  Text(
                                    sunset,
                                    style: GoogleFonts.kanit(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadData() async {
    try {
      final data = await ApiService().fetchSunriseSunset(
        mylocationlat: 14.020308,
        mylocationlng: 100.000322,
      );
      setState(() {
        sunriseSunsetData = data;
      });

      print(sunriseSunsetData.results?.sunrise);
    } catch (e) {
      print("Error: $e");
    }
  }
}
