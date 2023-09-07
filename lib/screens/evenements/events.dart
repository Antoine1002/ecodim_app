import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class EvenementPage extends StatefulWidget {
  @override
  _EvenementPageState createState() => _EvenementPageState();
}

class _EvenementPageState extends State<EvenementPage> {
  List<Publication> publications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fil d\'actualité'),
      ),
      body: PublicationList(publications: publications),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToCreatePublication();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToCreatePublication() async {
    final newPublication = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreatePublicationScreen()),
    );

    if (newPublication != null) {
      setState(() {
        publications.add(newPublication);
      });
    }
  }
}

class CreatePublicationScreen extends StatefulWidget {
  @override
  _CreatePublicationScreenState createState() =>
      _CreatePublicationScreenState();
}

class _CreatePublicationScreenState extends State<CreatePublicationScreen> {
  TextEditingController _contentController = TextEditingController();
  Color _selectedColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer une publication'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Contenu de la publication',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final newPublication = Publication(
                  content: _contentController.text,
                  likes: 0,
                );
                Navigator.pop(context, newPublication);
              },
              child: Text('Publier'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Couleur de fond'),
                GestureDetector(
                  onTap: () {
                    _showColorPickerDialog();
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: _selectedColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showColorPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Sélectionner une couleur'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedColor,
              onColorChanged: (color) {
                setState(() {
                  _selectedColor = color;
                });
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Valider'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class PublicationList extends StatelessWidget {
  final List<Publication> publications;

  PublicationList({required this.publications});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: publications.length,
      itemBuilder: (context, index) {
        return PublicationItem(publication: publications[index]);
      },
    );
  }
}

class PublicationItem extends StatefulWidget {
  final Publication publication;

  PublicationItem({Key? key, required this.publication}) : super(key: key);

  @override
  State<PublicationItem> createState() => _PublicationItemState();
}

class _PublicationItemState extends State<PublicationItem> {
  bool _isLiked = false;
  String _selectedReaction = 'like';
  List<String> _reactions = ['like', 'happy', 'sad', 'angry'];
  Color _backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _backgroundColor,
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nom de l\'utilisateur',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(widget.publication.content),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onLongPress: () {
                        _showReactionsDialog();
                      },
                      child: _selectedReaction != 'like'
                          ? Row(
                              children: [
                                Icon(_getReactionIcon(_selectedReaction)),
                                SizedBox(width: 5),
                                Text(_selectedReaction),
                              ],
                            )
                          : IconButton(
                              icon: Icon(
                                _isLiked
                                    ? Icons.thumb_up_alt
                                    : Icons.thumb_up_alt_outlined,
                                color: _isLiked ? Colors.blue : null,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isLiked = !_isLiked;
                                  if (_isLiked) {
                                    widget.publication.likes++;
                                  } else {
                                    widget.publication.likes--;
                                  }
                                });
                              },
                            ),
                    ),
                    SizedBox(width: 5),
                    Text('${widget.publication.likes} likes'),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {
                    // Ouvrir l'écran des commentaires ici.
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showReactionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Choisissez une réaction'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _reactions.map((reaction) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedReaction = reaction;
                    });
                    Navigator.of(dialogContext).pop();
                  },
                  child: Row(
                    children: [
                      Icon(_getReactionIcon(reaction)),
                      SizedBox(width: 10),
                      Text(reaction),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  IconData _getReactionIcon(String reaction) {
    switch (reaction) {
      case 'like':
        return Icons.thumb_up;
      case 'happy':
        return Icons.sentiment_satisfied;
      case 'sad':
        return Icons.sentiment_dissatisfied;
      case 'angry':
        return Icons.sentiment_very_dissatisfied;
      default:
        return Icons.thumb_up;
    }
  }
}

class Publication {
  final String content;
  int likes;

  Publication({required this.content, this.likes = 0});
}
