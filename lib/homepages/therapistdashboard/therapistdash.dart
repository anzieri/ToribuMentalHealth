import "package:app2/buttons/questionbuttons.dart";
import "package:app2/homepages/clientdashboard/firstoption.dart";
import "package:app2/homepages/clientdashboard/secondoption.dart";
import "package:app2/homepages/clientdashboard/thirdoption.dart";
import "package:app2/homepages/therapistdashboard/therapisthome.dart";
import "package:app2/login/authprovider.dart";
import "package:flutter/material.dart";
import "package:jwt_decoder/jwt_decoder.dart";
import "package:provider/provider.dart";

class TherapistDashboard extends StatefulWidget {
  const TherapistDashboard({super.key});

  @override
  State<TherapistDashboard> createState() => _TherapistDashboardState();
}

class _TherapistDashboardState extends State<TherapistDashboard> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const TherapistHomePage(), // Add const here
    const Appointments(),
    const ClientAppointments(),
  ];

  Future<String?> getName() async {
    String? tokeni =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    if (tokeni != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(tokeni);
      return decodedToken['firstName'];
    }
    return null;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(238, 240, 243, 247),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                        //color: const Color.fromARGB(238, 240, 243, 247),
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image.asset(
                              // 'assets/pics/fixedpi.png',
                              // height: 80,
                              // ),
                              const Text(
                                "Toribu",
                                style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButtons(
                          btnName: "Journal",
                          colour: Color.fromARGB(255, 55, 21, 150),
                          textColour: Colors.white,
                          //bordercolour: Colors.transparent,
                          containWidth: 200,
                          containHeight: 50,
                          radius: 20,
                          onPressed: () {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.home,
                          ),
                          title: const Text('Dashboard',
                              style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black)),
                          contentPadding: EdgeInsets.fromLTRB(80, 0, 70, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onTap: () {
                            _onItemTapped(0);
                            // Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.fromLTRB(80, 0, 70, 0),
                          leading: const Icon(Icons.folder),
                          title: const Text('Clients',
                              style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onTap: () {
                            _onItemTapped(1);
                            // Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.fromLTRB(80, 0, 70, 0),
                          leading: const Icon(Icons.bar_chart),
                          title: const Text('Appointments',
                              style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onTap: () {
                            _onItemTapped(2);
                            // Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                        QButtons(
                            btnName: "Kerubo",
                            colour: Colors.grey,
                            textColour: Colors.black,
                            containWidth: 400,
                            containHeight: 50,
                            radius: 9,
                            onPressed: () {}),
                        ListTile(
                          contentPadding: EdgeInsets.fromLTRB(80, 0, 70, 0),
                          leading: const Icon(Icons.dangerous),
                          title: const Text('Logout',
                              style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onTap: () {
                            // _onItemTapped(1);
                            // Navigator.pop(context);
                          },
                        ),
                      ],
                    ))),
                Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 80,
                                margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                                alignment: Alignment.center,
                                // decoration: BoxDecoration(
                                //   color: const Color.fromARGB(238, 240, 243, 247),
                                // ),
                                child: const Text("Help?",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black)),
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: const NetworkImage(
                                  'https://via.placeholder.com/150', // Replace with actual profile image URL
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 30, 0),
                              child: FutureBuilder<String?>(
                                future: getName(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return const Text("Error loading email");
                                  } else {
                                    return Text(snapshot.data ?? "No Email",
                                        style: const TextStyle(
                                          fontFamily: 'Lexend',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ));
                                  }
                                },
                              ),
                              ),
                            ]),
//CUT FROM HERE AND PUT IN NEW FILE FOR READABILITY

                        _widgetOptions.elementAt(_selectedIndex),
                      ],
                    )),
              ],
            ),
          ],
        ));
  }
}

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: TherapistDashboard()));
}
