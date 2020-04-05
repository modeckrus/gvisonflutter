import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gvision/widget/MyWrapper.dart';
import 'package:gvision/widget/postimagegallary.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import './my_flutter_app_icons.dart';

class PostItem extends StatefulWidget {
  final DocumentSnapshot doc;
  Post post;
  final String uid;

  PostItem({Key key, @required this.doc, @required this.uid})
      : super(key: key) {
    post = Post.fromDocSnap(doc);
    print(post);
  }

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    //var buttonSize = Size(50, 50);
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black,
            ),
            title: Text(widget.post.nick),
            subtitle: Text(DateFormat("yy-MM-dd - kk:mm").format(widget.post.createdAt)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.post.title,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.post.body,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          MyWrapper(
            images: widget.post.images,
            isOffline: false,
          ),
          Container(
            child: Row(
              children: <Widget>[
                LikeButton(
                  size: 40,
                  circleColor: CircleColor(
                      start: Color(0xff00ddff), end: Color(0xff0099cc)),
                  bubblesColor: BubblesColor(
                    dotPrimaryColor: Color(0xff33b5e5),
                    dotSecondaryColor: Color(0xff0099cc),
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      CustomIcon.heart,
                      color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                      size: 35,
                    );
                  },
                  likeCount: widget.post.likes,
                  onTap: (isliked) async {
                    if (isliked) {
                      print('unlike');
                    } else {
                      print('like');
                    }
                    return !isliked;
                  },
                  countBuilder: (int count, bool isLiked, String text) {
                    var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                    Widget result;
                    result = Text(
                      text,
                      style: TextStyle(color: color, fontSize: 20),
                    );
                    return result;
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Post extends Equatable {
  final String title;
  final String body;
  final String nick;
  final String uid;
  final bool hasattach;
  final List<String> images;
  final int likes;
  final String avatar;
  final DateTime createdAt;
  final String lastComment;

  Post({
    @required this.title,
    @required this.body,
    @required this.nick,
    @required this.hasattach,
    @required this.images,
    @required this.likes,
    @required this.uid,
    @required this.avatar,
    @required this.createdAt,
    @required this.lastComment,
  });
  factory Post.fromDocSnap(DocumentSnapshot post) {
    if (post['Hasattach'] == true) {
      var imgs = post['Images'];
      var listImage = List<String>();
      for (var i = 0; i < imgs.length; i++) {
        print(imgs);
        listImage.add(imgs[i]);
      }
      return Post(
        title: post['Title'],
        body: post['Body'],
        nick: post['Nick'],
        hasattach: post['Hasattach'],
        images: listImage,
        likes: post['Likes'],
        uid: post['UserID'] ?? "",
        avatar: post['Avatar'],
        createdAt: post['CreatedAt'].toDate(),
        lastComment: post['LastComment'],
      );
    } else {
      return Post(
        title: post['Title'],
        body: post['Body'],
        nick: post['Nick'],
        hasattach: post['Hasattach'],
        images: null,
        likes: post['Likes'],
        uid: post['UserID'] ?? "",
        avatar: post['Avatar'],
        createdAt: post['CreatedAt'].toDate(),
        lastComment: post['LastComment'],
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Body': body,
      'Nick': nick,
      'Hasattach': hasattach,
      'Images': images,
      'Likes': likes,
      'UserID': uid,
      'Avatar':avatar,
      'CreatedAt': createdAt,
      'LastComment':lastComment,
    };
  }

  @override
  String toString() {
    return "Post: title: $title, dname: $nick, body: $body, hasattach: $hasattach, likes: $likes, images: $images, uid: $uid, avatar: $avatar, createdAt: $createdAt, lastcomment: $lastComment";
  }

  @override
  List<Object> get props => [title, body, nick, hasattach, likes, images, uid, avatar, createdAt, lastComment];
}

/*

ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
              ),
              title: Text(widget.post["Title"]),
              subtitle: Text(widget.post["Dname"]),
            ),

*/
