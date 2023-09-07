// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// class Cours_biblique extends StatefulWidget {
//   const Cours_biblique({super.key});

//   @override
//   State<Cours_biblique> createState() => _Cours_bibliqueState();
// }

// class _Cours_bibliqueState extends State<Cours_biblique> {
//   bool isPlaying = false;
//   late final AudioPlayer player;
//   late final AssetSource path;
//   Duration _duration = const Duration();
//   Duration _position = const Duration();

//   @override
//   void initState() {
//     initPlayer();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     player.dispose();
//     super.dispose();
//   }

//   Future initPlayer() async {
//     player = AudioPlayer();
//     path = AssetSource('audio/correct.mp3');

//     player.onDurationChanged.listen((Duration d) {
//       setState(() => _duration = d);
//     });
//     player.onPositionChanged.listen((Duration p) {
//       setState(() => _position = p);
//     });
//     player.onPlayerComplete.listen((_) {
//       setState(() => _position = _duration);
//     });
//   }

//   void playPause() async {
//     if (isPlaying) {
//       playPause();
//       isPlaying = false;
//     } else {
//       player.play(path);
//       isPlaying = true;
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const AudioInfo(),
//             const SizedBox(
//               height: 50,
//             ),
//             Slider(
//               value: _position.inSeconds.toDouble(),
//               onChanged: (value) async {
//                 await player.seek(Duration(seconds: value.toInt()));
//                 setState(() {});
//               },
//               min: 0,
//               max: _duration.inSeconds.toDouble(),
//               inactiveColor: Colors.grey,
//               activeColor: Colors.red,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 // Text(_duration.format()),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     player.seek(Duration(seconds: _position.inSeconds - 10));
//                     setState(() {});
//                   },
//                   child: Image.asset('assets/icons/rewind.png'),
//                 ),
//                 InkWell(
//                     onTap: playPause,
//                     child: Icon(
//                       isPlaying ? Icons.pause_circle : Icons.play_circle,
//                       color: Colors.red,
//                       size: 80,
//                     ))
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AudioInfo extends StatelessWidget {
//   const AudioInfo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [Image.asset('assets/gospels.png')],
//     );
//   }
// }
