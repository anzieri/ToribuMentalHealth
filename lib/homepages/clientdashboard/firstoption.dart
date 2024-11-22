import 'package:app2/requests/requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../buttons/buttons.dart';

class FirstOption extends StatefulWidget {
  const FirstOption({super.key});

  @override
  State<FirstOption> createState() => _FirstOptionState();
}

class _FirstOptionState extends State<FirstOption> {
  late Future<Map<String, dynamic>> quoteFuture;

  @override
  void initState() {
    super.initState();
    quoteFuture = getQuote("http://api.quotable.io/quotes/random");
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController journalController = TextEditingController();
    String? journal = journalController.text;
    //Future<Map<String, dynamic>> quoteFuture = getQuote("http://api.quotable.io/quotes/random");
    //Map<String, dynamic> quote = getQuote("http://api.quotable.io/quotes/random") as Map<String, dynamic>;
    Map<String, dynamic> journalData = {"journal": journal};
    
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 209, 192, 143),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),

      height: MediaQuery.of(context).size.height, // Constrain the height
      child: SingleChildScrollView(
       
        child: Container(
          margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text("Hi there!",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 80,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(height: 30),
                  Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 500,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: Color.fromARGB(100, 231, 231, 231),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 50, 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 30),
                                      const Text(
                                          "Journal Entries\nHow do you feel currently?",
                                          style: TextStyle(
                                            fontFamily: 'Lexend',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      SizedBox(height: 30),
                                      TextField(
                                        maxLines: null,
                                        minLines: 9,
                                        controller: journalController,
                                        keyboardType: TextInputType.multiline,
                                        decoration: const InputDecoration(
                                          hintText:
                                              'Enter your thoughts here...',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Align(
                                          alignment: Alignment.bottomRight,
                                          child: Buttons(
                                              btnName: "Predict",
                                              colour: Colors.black,
                                              containWidth: 150,
                                              containHeight: 50,
                                              radius: 10,
                                              onPressed: () {}))
                                    ],
                                  ),
                                ))
                          ],
                        )),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 250,
                                    padding: const EdgeInsets.fromLTRB(
                                        30, 30, 20, 20),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      color: Color.fromARGB(100, 231, 231, 231),
                                    ),
                                    child: Column(
                                      //mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text("Quote of The Day:",
                                              style: TextStyle(
                                                fontFamily: 'Lexend',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              )),
                                        ),
                                        SizedBox(height: 15),
                                        FutureBuilder<Map<String, dynamic>>(
                                          future: quoteFuture,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            } else if (snapshot.hasData) {
                                              var quote = snapshot.data!;
                                              return  Container(
                                                    
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius: BorderRadius.circular(20)
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            quote['content'],
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 21,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Text(
                                                            '- ${quote['author']}',
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                            } else {
                                              return const Text(
                                                  'No quote available');
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    height: 240,
                                    padding: const EdgeInsets.fromLTRB(
                                        30, 30, 20, 20),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      color: Color.fromARGB(100, 231, 231, 231),
                                    ),
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text("Appointments",
                                              style: TextStyle(
                                                fontFamily: 'Lexend',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              )),
                                        ),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                                "No appointments scheduled",
                                                style: TextStyle(
                                                  fontFamily: 'Lexend',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w300,
                                                )))
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        )
                      ]),
                ]),

            // Row(
            //   FutureBuilder<String?>(
            //   future: getName(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const CircularProgressIndicator();
            //     } else if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}');
            //     } else {
            //       return Text(snapshot.data ?? '');
            //     }
            //   },
            // ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FirstOption(),
  ));
}
