import 'package:flutter/material.dart';

class Parmetre extends StatefulWidget {
  @override
  _ParmetreState createState() => _ParmetreState();
}

class _ParmetreState extends State<Parmetre> {
  Color _pageColor = Colors.white; // Couleur de la page par défaut

  void _changePageColor(Color color) {
    setState(() {
      _pageColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Changer la Couleur de la Page'),
      ),
      backgroundColor: _pageColor, // Utilisez la couleur de la page ici
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(_changePageColor),
              ),
            );
          },
          child: Text('Changer la Couleur'),
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  final Function(Color) onChangeColor;

  SettingsPage(this.onChangeColor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Sélectionnez une couleur pour la page :'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onChangeColor(Colors.red);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: Text('Rouge'),
            ),
            ElevatedButton(
              onPressed: () {
                onChangeColor(Colors.blue);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: Text('Bleu'),
            ),
            ElevatedButton(
              onPressed: () {
                onChangeColor(Colors.green);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: Text('Vert'),
            ),
          ],
        ),
      ),
    );
  }
}
