import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gvision/authentication_bloc/authentication_bloc.dart';
import 'package:gvision/widget/MyWrapper.dart';
import 'package:gvision/widget/PostItem.dart';
import 'package:gvision/widget/createPost.dart';
import 'package:gvision/widget/test.dart';
class HomeScreen extends StatelessWidget {
  final String name;
  final String uid;
  HomeScreen({Key key, @required this.name, @required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    test();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoggedOut(),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return CreatePostWidget(
                    uid: uid,
                  );
                }
              ));
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), title: Text('title')),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), title: Text('title')),
        ],
      ),
      body: Center(
        child: StreamBuilder(
            stream: Firestore.instance.collection('feedline').document(uid).collection("post").snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return const Text('void data');
              }
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index){
                  DocumentSnapshot post = snapshot.data.documents[index];
                  return PostItem(doc: post, uid: uid,);
                },
              );
            },
      ),
      )
    );
  }
}

