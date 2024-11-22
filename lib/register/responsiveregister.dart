import 'package:app2/register/register.dart';
import 'package:app2/register/registermobile.dart';
import 'package:flutter/material.dart';

class Responsiveregister extends StatelessWidget {
  const Responsiveregister({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth > 600){
          return const RegisterUI(role: '');
        }else{
          return const RegisterMobileUI();
        }
      },
    );
    }
}