import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media_app/app/ui/widgets/post_widget.dart';

import '../../data/models/post_model.dart';

class ProfilePost extends StatelessWidget {
  final List<Post> posts;
  const ProfilePost({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        backgroundColor: Colors.black,
        leading:Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black,size: 30,),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        leadingWidth: 45,
        title: const Text('Post' ,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xFF836F71)),),
        shadowColor: Colors.black,
        titleSpacing: 0,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount:posts.length,
        itemBuilder: (context, index)=> PostCard(
          post:posts[index],
        ),
      ),
    );
  }
}
