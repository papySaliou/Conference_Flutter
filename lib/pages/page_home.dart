
// import 'package:conference/pages/page_event.dart';
import 'package:flutter/material.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Conférence 2025',
              style: TextStyle(fontSize: 42),
            ),
            const Text(
              'Salon virtuel de la technologie du 18 au 25 février 2025',
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            
          ],
        ),
      );
  }
}