import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.searchController, required this.focusNode, this.onTap, this.onSubmitted});

  final TextEditingController searchController ;
  final FocusNode focusNode ;
  final void Function()? onTap;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Row(
          children: [
            Image.asset('assets/images/youtube.png',width: 36, ),
            const SizedBox(width: 8,),
            const Text('YouTube', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),),
            SizedBox(width: 10,),
            Expanded(
              child: CupertinoTextField(
                controller: searchController,
                focusNode: focusNode,
                placeholder: "Search...",
                placeholderStyle: TextStyle(color: Colors.black54),
                prefix: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(CupertinoIcons.search, color: Colors.black54,size: 20,),
                ),
                suffix:  Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(Icons.cancel_outlined, color: Colors.redAccent,size: 20,),
                ),
                style: TextStyle(color: Colors.black),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                onTap: onTap,
                onSubmitted: onSubmitted,
              ),
            ),
            
          ],
        );
  }
}