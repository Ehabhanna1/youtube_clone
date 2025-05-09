import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
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
          title: Row(
            children: [
              Image.asset('assets/images/youtube.png',width: 36, ),
              const SizedBox(width: 8,),
              const Text('YouTube', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),),
              SizedBox(width: 10,),
              Expanded(
                child: CupertinoTextField(
                  controller: searchController,
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
                  onTap: () {},
                  onSubmitted: (value) {},
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}