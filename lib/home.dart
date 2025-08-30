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

class _HomepageState extends State<Homepage> {
  late SunTimes sunriseSunsetData;
  late SunTimes chiangmaiSunsetData;
  @override
  void initState() {
    tz.initializeTimeZones();
    super.initState();
    sunriseSunsetData = SunTimes();
    chiangmaiSunsetData = SunTimes();
    loadData();
    loadChiangmaiData();
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),

                color: const Color.fromARGB(255, 255, 255, 255),
              ),

              height: 80,
              width: 400,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Text('Chiangmai', style: GoogleFonts.kanit(fontSize: 16)),

                  SizedBox(width: 150),
                  Row(
                    spacing: 25,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.north),
                          Text(
                            '${chiangmaiSunsetData.results?.sunrise ?? 'Loading...'}',
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
                            '${chiangmaiSunsetData.results?.sunset ?? 'Loading...'}',
                            style: GoogleFonts.kanit(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
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

  void loadChiangmaiData() async {
    try {
      final data = await ApiService().fetchSunriseSunset(
        mylocationlat: 18.777806,
        mylocationlng: 98.995495,
      );
      setState(() {
        chiangmaiSunsetData = data;
      });

      print(chiangmaiSunsetData.results?.sunrise);
    } catch (e) {
      print("Error: $e");
    }
  }
}
