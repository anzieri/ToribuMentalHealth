import "package:app2/buttons/buttons.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class CareersPage extends StatelessWidget {
  const CareersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(200, 80, 200, 0),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const SizedBox(height: 50),
          Container(
            constraints: const BoxConstraints(maxWidth: 300),
            child: const Text(
              "Looking for a career\nin therapy? Try Toribu!\nExperience True work Wellbeing",
              style: TextStyle(
                fontFamily: 'Baskerville',
                fontSize: 50,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 50),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Buttons(
                  btnName: "Register",
                  colour: Colors.black,
                  containWidth: 150,
                  containHeight: 50,
                  radius: 10,
                  onPressed: () => GoRouter.of(context).go("/register/THERAPIST"),
                ),
                const SizedBox(width: 20),
                Buttons(
                  btnName: "Login",
                  colour: Colors.grey,
                  containWidth: 150,
                  containHeight: 50,
                  radius: 10,
                  onPressed: () => GoRouter.of(context).go("/login"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
