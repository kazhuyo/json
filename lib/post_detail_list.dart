import 'package:flutter/material.dart';
import 'package:json/model.dart';

class PostDetailContent extends StatefulWidget {
  final CategoryPost detail;
  PostDetailContent({Key key, @required this.detail}) : super(key: key);

  _PostDetailContentState createState() => _PostDetailContentState();
}

class _PostDetailContentState extends State<PostDetailContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          widget.detail.postTitle
          ),
      ),
      body: Container(
        child: 
        new Text("I want to load here as list from postContent"),
        // getPosts(),
      ),
    );
  }

  Widget getPosts() {
    ListView detailPosts = new ListView.builder(
        itemCount: widget.detail.postContent.length,
        itemBuilder: (context, index) {
          return Row(
            children: <Widget>[
              new Text(
                widget.detail.postTitle
              )
            ],
          );
        });
    return detailPosts;
  }
}
