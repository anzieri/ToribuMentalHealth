import "package:app2/buttons/buttons.dart";
import "package:app2/requests/loginlogic.dart";
import "package:app2/requests/requests.dart";
import "package:flutter/material.dart";

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  late Future<List<dynamic>>therapistsFuture;

  @override
  void initState() {
    super.initState();
    therapistsFuture = findTherapists();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 209, 192, 143),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height -
            80, // Adjust this value as needed
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Matched Therapists",
              style: TextStyle(
                fontFamily: 'Lexend',
                fontSize: 40,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: therapistsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No therapists available'));
                }

                List<dynamic> therapists = snapshot.data!;
                try{
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: therapists.length,
                  itemBuilder: (context, index) {
                    try{
                    var therapist = therapists[index];
                    var specifics = therapist['therapistSpecifics']; // Access therapist specifics

                    // Check if specifics is null before accessing its properties
                    String specialization = specifics != null
                        ? specifics['specialization'] ?? 'Not specified'
                        : 'Not specified';
                    String experience = specifics != null
                        ? '${specifics['experience'] ?? 'Not specified'} years'
                        : 'Not specified';

                    return Card(
                      color: Colors.transparent,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                therapist['profileImage'] ??
                                    'https://via.placeholder.com/150',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${therapist['firstName']} ${therapist['lastName']}',
                                    style: const TextStyle(
                                      fontFamily: 'Lexend',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Specialization: $specialization', // Updated to use the null-checked variable
                                    style: const TextStyle(
                                      fontFamily: 'Lexend',
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Experience: $experience', // Updated to use the null-checked variable
                                    style: const TextStyle(
                                      fontFamily: 'Lexend',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Buttons(
                              btnName: "Match",
                              colour: Colors.transparent,
                              containWidth: 100,
                              containHeight: 40,
                              radius: 10,
                              onPressed: () {
                                showDialog(context: context, builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Select Therapist',
                                    style: const TextStyle(
                                            fontFamily: 'Lexend',
                                            fontSize: 20,
                                          ),),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'You have selected ${therapist['firstName']} ${therapist['lastName']} as your therapist.',
                                          style: const TextStyle(
                                            fontFamily: 'Lexend',
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        ElevatedButton(
                                          onPressed: () {
                                            try {
                                              storeTherapistEmail("${therapist['email']}");
                                            } catch (e) {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text('Error'),
                                                    content: Text('An error occurred while storing the therapist email\n$e'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                            
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Confirm'),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              }
                            ),
                          ],
                        ),
                      ),
                    );
                  }catch(e){
                    return Center(child: Text('Error: $e'));
                  }
                  },
                );
              } catch(e){
                return Center(child: Text('Error: $e'));
              }
              },
            ),
          ),
        ],
      ),
    );
  }
}
