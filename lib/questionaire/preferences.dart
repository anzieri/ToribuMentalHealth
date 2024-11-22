import 'package:app2/centered_view.dart';
import 'package:app2/index.dart';
import 'package:app2/questionaire/dropdown.dart';
import 'package:app2/requests/requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  int _currentStep = 0;
  final _formKeys =
      List.generate(3, (_) => GlobalKey<FormState>(), growable: true);

  // Form data
  String? gender;
  String? ageGroup;
  String? specialization;
  String? _religionImportance;
  String? religion;
  String? location;
  List<String> interests = [];

  String? therapyType;
  String? experienceLevel;
  String? preferredTime;

  final List<String> interestOptions = [
    'Reading',
    'Exercise',
    'Cooking',
    'Travel',
    'Technology',
    'Music'
  ];

  @override
  void initState() {
    super.initState();
    //_formKeys.addAll(List.generate(questionSteps.length, (_) => GlobalKey<FormState>()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile Preferences',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 30,
              fontWeight: FontWeight.w400,
            )),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary:
                  Colors.amber, // Color for the circle and line when active
              onSurface: Colors.amber, // Color for inactive elements
              background: Colors.white, // Background color
            ),
            canvasColor: Colors.white, // This affects the overall background
          ),
          child: CenteredView(
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: _currentStep,
              elevation: 0,
              onStepContinue: () {
                if (_currentStep < 2) {
                  if (_formKeys[_currentStep].currentState?.validate() ??
                      false) {
                    _formKeys[_currentStep].currentState?.save();
                    setState(() => _currentStep++);
                  }
                } else {
                  // Handle questionnaire completion
                  _submitQuestionnaire();
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() => _currentStep--);
                }
              },
              steps: [
                Step(
                  title: const Text('Basic Info'),
                  content: Form(
                    key: _formKeys[0],
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // QButtons(
                          //     btnName: "Individual",
                          //     colour: Colors.black,
                          //     textColour: Colors.white,
                          //     containWidth: 500,
                          //     containHeight: 50,
                          //     radius: 20,
                          //     onPressed: () {
                          //       print("individual");
                          //       String value = "Individual";
                          //       setState(() => therapyType = value);
                          //     }),

                          const Text(
                              'What gender would you prefer your therapist to be?:',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                              )),
                          const SizedBox(
                            height: 16,
                          ),

                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio<String>(
                                activeColor: Colors.amber,
                                value: 'Male',
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() => gender = value);
                                  if (_formKeys[0].currentState != null) {
                                    _formKeys[0].currentState!.validate();
                                  }
                                },
                              ),
                              const Text(
                                'Male',
                                style: TextStyle(
                                    fontFamily: 'Lexend', fontSize: 20),
                              ),
                              Radio<String>(
                                value: 'Female',
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() => gender = value);
                                  if (_formKeys[0].currentState != null) {
                                    _formKeys[0].currentState!.validate();
                                  }
                                },
                              ),
                              const Text(
                                'Female',
                                style: TextStyle(
                                    fontFamily: 'Lexend', fontSize: 20),
                              ),
                              Radio<String>(
                                value: 'Other',
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() => gender = value);
                                  if (_formKeys[0].currentState != null) {
                                    _formKeys[0].currentState!.validate();
                                  }
                                },
                              ),
                              const Text(
                                "Doesn't Matter",
                                style: TextStyle(
                                    fontFamily: 'Lexend', fontSize: 20),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),

                          const Text(
                              'What Type of Therapy are you looking for?:',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                              )),

                          const SizedBox(height: 16),

                          DripDown(
                              label: "Therapy Type",
                              items: ["Individual", "Couple", "Family"],
                              value: therapyType,
                              onChanged: (value) =>
                                  setState(() => specialization = value),
                              validator: (value) => value == null
                                  ? 'Please select therapy type'
                                  : null),

                          const SizedBox(
                            height: 50,
                          ),

                          const Text(
                              'How old would you prefer your therapist to be?',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                              )),

                          const SizedBox(
                            height: 16,
                          ),

                          DripDown(
                              label: "Age Group",
                              items: [
                                '18-25',
                                '26-35',
                                '36-45',
                                '46-60',
                                '60+'
                              ],
                              value: ageGroup,
                              onChanged: (value) =>
                                  setState(() => ageGroup = value),
                              validator: (value) => value == null
                                  ? 'Please select age group preference'
                                  : null),

                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Step(
                  title: const Text('Indepth Info'),
                  content: Form(
                    key: _formKeys[1],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Text('Select your interests:',
                        //     style: TextStyle(fontSize: 16)),
                        // const SizedBox(height: 8),
                        // Wrap(
                        //   spacing: 8,
                        //   children: interestOptions
                        //       .map(
                        //         (interest) => FilterChip(
                        //           label: Text(interest),
                        //           selected: interests.contains(interest),
                        //           onSelected: (selected) {
                        //             setState(() {
                        //               if (selected) {
                        //                 interests.add(interest);
                        //               } else {
                        //                 interests.remove(interest);
                        //               }
                        //             });
                        //           },
                        //         ),
                        //       )
                        //       .toList(),
                        // ),

                        const Text('How important is religion in your life?',
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                            )),

                        const SizedBox(
                          height: 16,
                        ),

                        DripDown(
                            label: "Religion Importance",
                            items: [
                              'Very Important',
                              'Important',
                              'Slightly Important',
                              'Not Important'
                            ],
                            value: _religionImportance,
                            onChanged: (value) =>
                                setState(() => _religionImportance = value),
                            validator: (value) => value == null
                                ? 'Please select religion importance'
                                : null),

                        const SizedBox(
                          height: 50,
                        ),

                        const Text('Which Religion do you identify with?',
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                            )),

                        const SizedBox(
                          height: 16,
                        ),

                        DripDown(
                            label: "Religion",
                            items: [
                              "CHRISTIANITY",
                              "ISLAM",
                              "HINDUISM",
                              "BUDDHISM",
                              "JUDAISM",
                              "ATHEISM",
                              "SPIRITUAL",
                              "OTHER"
                            ],
                            value: religion,
                            onChanged: (value) =>
                                setState(() => religion = value),
                            validator: (value) => value == null
                                ? 'Please select religion'
                                : null),

                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                Step(
                  title: const Text('Preferences'),
                  content: Form(
                    key: _formKeys[2],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                            "What is the minimum experience level you would prefer your therapist to have?",
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        DripDown(
                          label: "Experience Level",
                          items: [
                            'Beginner(0-2 years)',
                            'Intermediate(2-5 years)',
                            'Advanced(5-10)',
                                'Expert(10+)'
                          ],
                          value: experienceLevel,
                          onChanged: (value) =>
                              setState(() => experienceLevel = value),
                          validator: (value) => value == null
                              ? 'Please select experience level'
                              : null,
                        ),
                        const SizedBox(height: 50),
                        const Text(
                            "How available would you like your therapist to be?",
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                            )),
                        const SizedBox(height: 16),
                        DripDown(
                          label: "Preferred Time",
                          items: [
                            'FULLTIME',
                            'PARTTIME',
                            'NIGHTSHIFT',
                            'FLEXIBLE'
                          ],
                          value: preferredTime,
                          onChanged: (value) =>
                              setState(() => preferredTime = value),
                          validator: (value) => value == null
                              ? 'Please select preferred time'
                              : null,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                            'Where would you prefer your therapist to reside from?',
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        DripDown(
                            label: "Location",
                            items: [
                              'Nairobi',
                              'Mombasa',
                              'Nakuru',
                              'Ruiru',
                              "Eldoret",
                              "Kisumu",
                              "Kikuyu",
                              "Ngong",
                              "Mavoko",
                              "Thika",
                              "Naivasha",
                              "Karuri",
                              "Kitale",
                              "Juja",
                              "Kitengela",
                              "Kiambu",
                              "Malindi",
                              "Mandera",
                              "Kisii",
                              "Kakamega"
                            ],
                            value: location,
                            onChanged: (value) =>
                                setState(() => location = value),
                            validator: (value) => value == null
                                ? 'Please select a preferred location'
                                : null),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void cleanData(
      //String? specialize, String? ageGroupy, String? Experience
      ) {
    switch (experienceLevel) {
      case "Beginner(0-2 years)":
        experienceLevel = "BEGINNER";
        break;
      case "Intermediate(2-5 years)":
        experienceLevel = "INTERMEDIATE";
        break;
      case "Advanced(5-10)":
        experienceLevel = "ADVANCED";
        break;
      case "Expert(10+)":
        experienceLevel = "EXPERT";
        break;
      default:
        experienceLevel;
        break;
    }

    if (specialization == "Couple" || specialization == "Family") {
      specialization = "MarriageandFamilyTherapist";
    } else {
      specialization = "Psychologist";
    }

    switch (ageGroup) {
      case "18-25":
        ageGroup = "BELOW25";
        break;
      case "26-35":
        ageGroup = "BETWEEN25AND35";
        break;
      case "36-45":
        ageGroup = "BETWEEN36AND45";
        break;
      case "46-60":
        ageGroup = "BETWEEN46AND60";
        break;
      case "Above 60":
        ageGroup = "ABOVE60";
        break;
      default:
        ageGroup; // Handle unexpected values
        break;
    }
  }

  void _submitQuestionnaire() {
    // Add your submission logic here
    if (_formKeys[2].currentState?.validate() ?? false) {
      _formKeys[2].currentState?.save();

      cleanData();
      Map<String, Object> savePreferences = {
        "experienceLevel": "$experienceLevel",
        "availability": "$preferredTime",
        //"approach": "$approach",
        "religion": "$religion",
        "specialization": "$specialization",
        "ageGroup": "$ageGroup",
        "location": "$location",
        "gender": "$gender"
      };

      print(savePreferences);
      postPreferences(savePreferences);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Questionnaire submitted successfully!')),
      );

      context.goNamed("Login");
    }
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PreferencesPage(),
  ));
}
