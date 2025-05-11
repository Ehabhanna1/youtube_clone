
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone_app/core/widgets/custom_text.dart';

class VideoItem extends StatelessWidget {
  const VideoItem({super.key, required this.videoImage, required this.videoTitle, required this.channelName, required this.channelImage, required this.videoViews, required this.timing, required this.duration});


  final String videoImage,videoTitle,channelName,channelImage,videoViews,timing,duration;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.network(videoImage,
              fit: BoxFit.cover,
              width: size.width,
             
             
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: CustomText(text: duration, fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )
          ],
        ),
        const SizedBox(height:15),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
               CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(channelImage),
              ),
              const SizedBox(width: 8),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.7,
                  child: AutoSizeText(
                    videoTitle,
                    minFontSize: 15,
                    maxFontSize: double.infinity,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  
                  
                  ),
                ),
               
                SizedBox(
                  width: size.width * 0.7,
                  child: AutoSizeText(
                      "$channelName . $videoViews . $timing",
                      minFontSize: 13,
                      maxFontSize: double.infinity,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                  
                  
                   
                  ),
                ),
              ],
             ),
              
          
            ],
          ),
        ),
      ],
    );
  }
}