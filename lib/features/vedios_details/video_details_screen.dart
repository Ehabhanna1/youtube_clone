import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skeletonizer/skeletonizer.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone_app/core/connstants/app_consts.dart';


class VideoDetailsScreen extends StatefulWidget {
  const VideoDetailsScreen({super.key, required this.videoId});

  final String videoId;
  

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  late VideoPlayerController? controller;

  List videos = [];
  bool isLoading = false;
  Map <String, dynamic>? videoInfo; 
  Future<void> getVideoDetails() async {
    final id = widget.videoId;
    final uri = '${AppConsts.baseUrl}/v2/video/details?videoId=$id';
    final url = Uri.parse(uri);
    final response = await http.get(url, headers: AppConsts.headers);

    final json = jsonDecode(response.body) as Map<String, dynamic>?;
    if (json == null ||json['videos'] == null|| json['videos']['items'] == null) {
      throw Exception('Invalid response');
    }
    final videoList= json['videos']['items'] ;
    if (videoList.isEmpty || videoList[0]['url'] == null) {
      throw Exception('No videos found');
    }
    final videoLink = videoList[0]['url'] ;

    setState(() {
      videoInfo = json;
      isLoading = true;
    });

    controller = VideoPlayerController.networkUrl(
      Uri.parse(videoLink),)..initialize().then((v) {
        setState(() {
          controller!.play();
        });
      });
  

  }

  @override
  void initState() {
    getVideoDetails();
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 8,
        //title: Text('Video Details'),
      ),
      body: isLoading ? Center(child: CupertinoActivityIndicator() ):
      (videoInfo == null || controller == null) ? Center(child: CupertinoActivityIndicator()) :
      Column(
        children: [
         AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
          child: VideoPlayer( controller!)),
         
          
        ]
      ),
    );
  }
}
