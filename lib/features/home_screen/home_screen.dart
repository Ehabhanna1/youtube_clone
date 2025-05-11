import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_clone_app/core/connstants/app_consts.dart';
import 'package:youtube_clone_app/core/video_item.dart';
import 'package:youtube_clone_app/features/home_screen/widgets/custom_app_bar.dart';
import 'package:youtube_clone_app/features/vedios_details/video_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  List items = [];

  bool isClear = false;
  bool isLoading = false;

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
        setState(() {
          isClear = false;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: CustomAppBar(
            searchController: searchController,
            focusNode: focusNode,
            onTap: () {
              setState(() {
                isClear = true;
              });
              // focusNode.requestFocus();
            },
            onSubmitted: (value) {
              setState(() {
                searchVideos(value);
              });
            },
             suffix: isClear ? Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        searchController.clear();
                      });
                    },
                    icon: const Icon(Icons.cancel, color: Colors.redAccent, size: 18,),
                  ),
                ):SizedBox.shrink(),
          ),
        ),
        body: isLoading ? const Center(child: CupertinoActivityIndicator()) : ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final id = item['id'];
            return GestureDetector(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
               await Navigator.push(context, MaterialPageRoute(builder: (context) => VideoDetailsScreen(videoId:id ,),));
                setState(() {
                  isLoading = false;
                });
              },
              child: VideoItem(
                videoImage: item['thumbnails'][0]['url'],
                videoTitle: item['title'],
                channelName: item['channel']['name'],
                channelImage: item['channel']['avatar'][0]['url'],
                timing: item['publishedTimeText'],
                videoViews: item['viewCountText'],
                duration: item['lengthText'],
              ),
            );
          },
        ),
      ),
    );
  }
}
