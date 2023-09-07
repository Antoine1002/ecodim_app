import 'package:flutter/material.dart';
import 'package:ecodim_app/screens/quizz/normal.dart';

class CongratulationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Félicitations, vous avez terminé le quiz!"),
            ElevatedButton(
              onPressed: () {
                // Naviguer vers la page du niveau
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => NormalLevel(),
                ));
              },
              child: Text("Recommencer"),
            ),
          ],
        ),
      ),
    );
  }
}
