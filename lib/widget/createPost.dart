import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gvision/imagesender/image_capture.dart';
import 'package:gvision/widget/MyWrapper.dart';

class CreatePostWidget extends StatefulWidget {
  CreatePostWidget({Key key, @required this.uid}) : super(key: key);
  final String uid;
  List<String> images = List<String>();
  List<String> path = List<String>();
  
  String title = 'Title';
  String body = 'Body';
  
  @override
  _CreatePostWidgetState createState() => _CreatePostWidgetState();
}

class _CreatePostWidgetState extends State<CreatePostWidget> {
  var _titleController = TextEditingController(text: 'Title');
  var _bodyController = TextEditingController(text: 'Body');
  @override
  void initState() {
    super.initState();
    _titleController.addListener((){
      widget.title = _titleController.text;
    });
    _bodyController.addListener((){
      widget.body = _bodyController.text;
    });
  }
  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CreatePost'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                bool hasattach;
                if(widget.images == null || widget.images == List<String>()||widget.images.length <= 0){
                  hasattach = false;
                  widget.images = null;
                }else{
                  hasattach = true;
                }
                Firestore.instance.collection('posts').document(widget.uid).collection('edition').add({
                  'Title':widget.title,
                  'Body':widget.body,
                  'Hasattach': hasattach,
                  'Images': widget.path
                });
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Укажите название вашего поста, а также заполнити его описание, добавьте фотографии по желанию',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: _titleController,
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: _bodyController,

              ),
              SizedBox(
                height: 50,
              ),
              MyWrapper(images: widget.images, isOffline: true,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo),
                      iconSize: 100,
                      onPressed: () async {
                        final result = await Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ImageCapture(uid: widget.uid, path: "posts");
                        }));
                        if (result != null) {
                          widget.path.add(result[1]);
                          setState(() {
                            print(result);
                            widget.images.add(result[0]);
                          });
                        } else {
                          
                        }
                      },
                    ),
                    decoration: BoxDecoration(color: Colors.black38),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.insert_drive_file),
                      iconSize: 100,
                      onPressed: () {},
                    ),
                    decoration: BoxDecoration(color: Colors.black38),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.library_music),
                      iconSize: 100,
                      onPressed: () {},
                    ),
                    decoration: BoxDecoration(color: Colors.black38),
                  ),
                ],
              ),
              
            ],
          ),
        ));
  }
}
