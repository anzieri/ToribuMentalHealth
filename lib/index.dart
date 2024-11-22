import "package:app2/navbar/navbar.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class Integrate extends StatelessWidget {
    final StatefulNavigationShell navigationShell;
  const Integrate( this.navigationShell, {super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: Colors.white,

      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: Navbar(),
      ),
      
      body: navigationShell,
     
      );
    }
    
}
