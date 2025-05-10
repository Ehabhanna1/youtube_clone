import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_clone_app/core/connstants/app_consts.dart';
import 'package:youtube_clone_app/core/video_item.dart';
import 'package:youtube_clone_app/features/home_screen/widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  List items = [];

  /// search video
  Future<void> searchVideos(String query) async {
    final uri =
        '${AppConsts.baseUrl}/v2/search/videos?keyword=$query&uploadDate=all&duration=all&sortBy=relevance';
    final url = Uri.parse(uri);
    final response = await http.get(url, headers: AppConsts.headers);
    final json = jsonDecode(response.body) as Map;
    final result = json['items'] as List;


    setState(() {
      items = result;
    });



    print(result);
  }

  @override
  void initState() {
    // TODO: implement initState
    searchVideos('flutter');
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: CustomAppBar(
            searchController: searchController,
            focusNode: focusNode,
            onTap: () {
              // focusNode.requestFocus();
            },
            onSubmitted: (value) {},
          ),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return VideoItem(
              videoImage: item['thumbnails'][0]['url'],
              videoTitle: item['title'],
              channelName: item['channel']['name'],
              channelImage: item['channel']['avatar'][0]['url'],
              timing: item['lengthText'],
              videoViews: item['viewCountText'],
            );
          },
        ),
      ),
    );
  }
}
