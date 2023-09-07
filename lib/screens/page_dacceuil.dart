import 'package:flutter/material.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({Key? key}) : super(key: key);

  @override
  State<Acceuil> createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  double imageSize = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        width: 200,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 130, // Définissez la hauteur souhaitée ici
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Paramètres',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('parmetre');
              },
            ),
            ListTile(
              title: Text(
                'Pourboire',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'A propos',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Gérer la navigation vers les paramètres ici
                Navigator.pop(context); // Ferme le tiroir
              },
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
      // appBar: AppBar(title: Text('cool')),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1 - 10),
        child: AppBar(
          backgroundColor: const Color.fromARGB(197, 230, 223, 223),
          // automaticallyImplyLeading: false,
          title: Row(
            children: [
              const Text(
                'ECODIM',
                style: TextStyle(
                    color: Color.fromARGB(255, 11, 114, 198),
                    fontSize: 50,
                    fontFamily: 'MAPOLICE'),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Image.asset(
                  'assets/appbar.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
      ),

      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 15,
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'AntoineLamah',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/tuto.png'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LayoutBuilder(
                  builder: (context, constraints) {
                    double containerSize = constraints.maxWidth / 2 - 20;
                    double imageSize = containerSize * 0.9;
                    const SizedBox(height: 8);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('levelpage');
                          },
                          child: Container(
                            width: constraints.maxWidth / 2 - 20,
                            height: constraints.maxWidth / 1 - 150,
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  'assets/quizz.png',
                                  width: imageSize + 15,
                                  height: imageSize + 15,
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'QUIZZ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'MAPOLICE2'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('cours');
                            // Gérer le tap ici
                          },
                          child: Container(
                            width: constraints.maxWidth / 2 - 20,
                            height: constraints.maxWidth / 1 - 150,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  'assets/cours.png',
                                  width: imageSize,
                                  height: imageSize,
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'COURS BIBLIQUES',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontFamily: 'MAPOLICE2',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // ... add more containers
                      ],
                    );
                  },
                ),

                const SizedBox(height: 8),
                const SizedBox(height: 20),
                LayoutBuilder(
                  builder: (context, constraints) {
                    double containerSize = constraints.maxWidth / 2 - 20;
                    double imageSize = containerSize * 0.9;
                    const SizedBox(height: 8);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('evenements');
                          },
                          child: Container(
                            width: constraints.maxWidth / 2 - 20,
                            height: constraints.maxWidth / 1 - 150,
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  'assets/evenements.png',
                                  width: imageSize + 20,
                                  height: imageSize + 40,
                                ),
                                const SizedBox(height: 1),
                                const Text(
                                  'EVENEMENTS',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontFamily: 'MAPOLICE3',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            // Gérer le tap ici
                          },
                          child: Container(
                            width: constraints.maxWidth / 2 - 20,
                            height: constraints.maxWidth / 1 - 150,
                            decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  'assets/temoignage.jpg',
                                  width: imageSize + 15,
                                  height: imageSize + 15,
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'TEMOIGNAGES',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontFamily: 'MAPOLICE3'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // ... add more containers
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                const SizedBox(width: 8),

                // ... repeat for other rows
              ],
            ),
          ),
        ),
      ),
    );
  }
}
