import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'video_info.dart'; // 追加

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YouTube Embed Player',
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'YouTube Embed Player',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purple,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ListView.builder(
                shrinkWrap: true, // ListViewの高さをコンテンツに合わせる
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return YoutubeWidget(
                    title: videos[index].title,
                    videoId: videos[index].videoId,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class YoutubeWidget extends StatelessWidget {
  final String title;
  final String videoId;

  const YoutubeWidget({required this.title, required this.videoId, super.key});

  @override
  Widget build(BuildContext context) {
    final youtubeController = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          YoutubePlayerScaffold(
            controller: youtubeController,
            aspectRatio: 16 / 9,
            builder: (context, player) {
              return player;
            },
          )
        ],
      ),
    );
  }
}
