/*import 'package:deeptrainfront/shared/widgets/header.dart';
import 'package:flutter/material.dart';

import '../shared/widgets/testimonial_section.dart';
import '../shared/widgets/footer.dart';
import '../shared/widgets/hero_section.dart' as hero;

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), // adjust height as needed
        child: const Header(),
      ),
      drawer: MediaQuery.of(context).size.width < 768
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: const [
                  DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                  ListTile(title: Text('Home')),
                  ListTile(title: Text('Dashboard')),
                  ListTile(title: Text('Login')),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            hero.HeroSection(),
            TestimonialSection(),
            Footer(),
          ],
        ),
      ),
    );
  }
}

*/