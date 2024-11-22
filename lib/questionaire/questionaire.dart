import 'package:app2/buttons/buttons.dart';
import 'package:app2/buttons/questionbuttons.dart';
import 'package:app2/centered_view.dart';
import 'package:app2/questionaire/dropdown.dart';
import 'package:app2/requests/requests.dart';
import 'package:app2/textfields/textfields.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Questionaire extends StatefulWidget {
  const Questionaire({super.key});

  @override
  State<Questionaire> createState() => _QuestionaireState();
}

class _QuestionaireState extends State<Questionaire> {
  int _currentStep = 0;
  final _formKeys =
      List.generate(3, (_) => GlobalKey<FormState>(), growable: true);

  // Form data
  String? gender;
  String? _religionImportance;
  String? qualification;
  String? religion;
  String? approach;
  List<String> interests = [];

  String? specialization;
  String? experience;
  String? ageGroup;
  String? experienceLevel;
  String? preferredTime;
  TextEditingController experienceController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
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
        title: const Text('Profile Questionnaire',
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
                          //qualification, specialization, licensoNO

                          const SizedBox(
                            height: 50,
                          ),

                          const Text('What type of therapist are you?',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                              )),

                          const SizedBox(height: 16),

                          DripDown(
                              label: "Therapist Type",
                              items: const [
                                "Clinical Social Worker",
                                "Marriage and Family Therapist",
                                "Mental Health Counselor",
                                "Professional Counselor",
                                "Psycologist"
                              ],
                              value: specialization,
                              onChanged: (value) =>
                                  setState(() => specialization = value),
                              validator: (value) => value == null
                                  ? 'Please select therapist type'
                                  : null),

                          const SizedBox(
                            height: 50,
                          ),

                          const Text(
                              'Which technical therapy approach are you most conversant in?',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                              )),

                          const SizedBox(
                            height: 16,
                          ),

                          DripDown(
                              label: "Therapy Approach",
                              items: const [
                                "CBT",
                                "PSYCHODYNAMIC",
                                "HUMANISTIC",
                                "BEHAVIOURAL",
                                "INTEGRATIVE",
                                "INTERPERSONAL",
                                "MBT",
                              ],
                              value: approach,
                              onChanged: (value) =>
                                  setState(() => approach = value),
                              validator: (value) => value == null
                                  ? 'Please select therapy approach'
                                  : null),

                          const SizedBox(
                            height: 50,
                          ),

                          const Text(
                              "Provide your certified License number below:",
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                              )),
                          const SizedBox(
                            height: 16,
                          ),

                          Textfields(
                            placeholder: "License",
                            containWidth: 300,
                            fieldDescription: "",
                            controller: licenseController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your license";
                              }
                              return null;
                            },
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
                        const Text(
                            'What is your current highest academic qualification?',
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                            )),

                        const SizedBox(height: 16),

                        DripDown(
                            label: "Qualification",
                            items: const [
                              "PhD",
                              "Masters",
                              "Bachelors",
                              "Diploma",
                              "Certification"
                            ],
                            value: qualification,
                            onChanged: (value) =>
                                setState(() => qualification = value),
                            validator: (value) => value == null
                                ? 'Please select highest qualification'
                                : null),

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
                            items: const [
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
                          height: 50,
                        ),

                        const Text('What age group do you belong to?',
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
                            items: ['18-25', '26-35', '36-45', '46-60', '60+'],
                            value: ageGroup,
                            onChanged: (value) =>
                                setState(() => ageGroup = value),
                            validator: (value) => value == null
                                ? 'Please select age group preference'
                                : null),
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
                            "What is your current experience level professionally as a therapist?",
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
                            "Kindly specify how many years of experience you have had as a therapist:",
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        Textfields(
                            placeholder: "Experience in Years",
                            containWidth: 300,
                            fieldDescription: "",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              } else if (value.contains(RegExp(r'[a-zA-Z] '))) {
                                return "Cannot contain letters";
                              } else if (value.length > 2) {
                                return "Cannot outlive lifespan";
                              }
                              return null;
                            },
                            controller: experienceController),
                        // DripDown(
                        //   label: "Experience Level",
                        //   items: [
                        //     'Beginner(0-2 years)',
                        //     'Intermediate(2-5 years)',
                        //     'Advanced(5+)'
                        //   ],
                        //   value: experience,
                        //   onChanged: (value) =>
                        //       setState(() => experience = value),
                        //   validator: (value) => value == null
                        //       ? 'Please select experience level'
                        //       : null,
                        // ),
                        const SizedBox(height: 50),
                        const Text(
                            "How available are you in terms of work hours?",
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                            )),
                        const SizedBox(height: 16),
                        DripDown(
                          label: "Availability",
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void cleanData() {
    specialization = specialization?.replaceAll(" ", "");

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

    switch (ageGroup) {
      case "18-25":
        ageGroup = "BELOW25";
        break;
      case "25-35":
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
      String exp = experienceController.text;
      String license = licenseController.text;

      Map<String, Object> saveDetails = {
        "experience": exp,
        "experienceLevel": "$experienceLevel",
        "availability": "$preferredTime",
        "qualification": "$qualification",
        "approach": "$approach",
        "ageGroup": "$ageGroup",
        "religion": "$religion",
        "licenseNo": license,
        "specialization": "$specialization"
      };

      print(saveDetails);
      postTherapistSpecifics(saveDetails);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Questionnaire submitted successfully!')),
      );
      context.goNamed('Login');
    }
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Questionaire(),
      backgroundColor: Colors.white,
    ),
  ));
}
