import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gvision/widget/postimagegallary.dart';

class MyWrapper extends StatelessWidget {
  MyWrapper({Key key, @required this.images, @required this.isOffline})
      : super(key: key);
  List<String> images = List<String>();
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://gvisionmodeck.appspot.com');
  final bool isOffline;
  Widget oneimage(context) {
    return SizedBox(
          child: Container(
            color: Colors.black,
            child: Image.file(File(images[0]), fit: BoxFit.cover,),
          ),
        );
  }

  Widget buildImage(context, id) {
    print(images);
    if (isOffline) {
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return PostImageGallary(
                imagespath: images,
                imageid: id,
                isOffline: isOffline,
              );
            }));
          },
          child: Container(
            color: Colors.black45,
            width: double.infinity,
            height: double.infinity,
            child: Image.file(
              File(images[id]),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      Future<dynamic> pdownload = _storage.ref().child(images[id]).getDownloadURL();

      pdownload.then((snapshot){
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PostImageGallary(
                  imagespath: images,
                  imageid: id,
                  isOffline: isOffline,
                );
              }));
            },
            child: Container(
              color: Colors.black45,
              width: double.infinity,
              height: double.infinity,
              child: CachedNetworkImage(
                imageUrl: snapshot.data,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            )));
      });
    }
  }

  Widget twoimages(context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 0.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(flex: 1, child: buildImage(context, 0)),
            Flexible(flex: 1, child: buildImage(context, 1))
          ],
        ));
  }

  Widget threeimages(context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(flex: 3, child: buildImage(context, 0)),
            Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(flex: 1, child: buildImage(context, 1)),
                    Flexible(flex: 1, child: buildImage(context, 2))
                  ],
                ))
          ],
        ));
  }

  Widget fourimages(context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(flex: 3, child: buildImage(context, 0)),
            Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(flex: 1, child: buildImage(context, 1)),
                    Flexible(flex: 1, child: buildImage(context, 2)),
                    Flexible(flex: 1, child: buildImage(context, 3)),
                  ],
                ))
          ],
        ));
  }

  Widget fiveimages(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(flex: 1, child: buildImage(context, 0)),
                Flexible(flex: 1, child: buildImage(context, 1))
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(flex: 1, child: buildImage(context, 2)),
                Flexible(flex: 1, child: buildImage(context, 3)),
                Flexible(flex: 1, child: buildImage(context, 4))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget siximages(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 1.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(flex: 5, child: buildImage(context, 0)),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(flex: 1, child: buildImage(context, 1)),
                Flexible(flex: 1, child: buildImage(context, 2)),
                Flexible(flex: 1, child: buildImage(context, 3)),
                Flexible(flex: 1, child: buildImage(context, 4)),
                Flexible(flex: 1, child: buildImage(context, 5)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget sevenimages(context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 1.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(flex: 3, child: buildImage(context, 0)),
                  Flexible(flex: 3, child: buildImage(context, 1)),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(flex: 2, child: buildImage(context, 2)),
                  Flexible(flex: 2, child: buildImage(context, 3)),
                  Flexible(flex: 2, child: buildImage(context, 4)),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(flex: 3, child: buildImage(context, 5)),
                  Flexible(flex: 3, child: buildImage(context, 6)),
                ],
              ),
            )
          ],
        ));
  }

  Widget eightimages(context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 1.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(flex: 3, child: buildImage(context, 0)),
                  Flexible(flex: 3, child: buildImage(context, 1)),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(flex: 2, child: buildImage(context, 2)),
                  Flexible(flex: 2, child: buildImage(context, 3)),
                  Flexible(flex: 2, child: buildImage(context, 4)),
                  Flexible(flex: 2, child: buildImage(context, 5)),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(flex: 3, child: buildImage(context, 6)),
                  Flexible(flex: 3, child: buildImage(context, 7)),
                ],
              ),
            )
          ],
        ));
  }

  Widget nineimages(context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 1.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(flex: 1, child: buildImage(context, 0)),
                  Flexible(flex: 1, child: buildImage(context, 1)),
                  Flexible(flex: 1, child: buildImage(context, 2)),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(flex: 1, child: buildImage(context, 3)),
                  Flexible(flex: 1, child: buildImage(context, 4)),
                  Flexible(flex: 1, child: buildImage(context, 5)),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(flex: 1, child: buildImage(context, 6)),
                  Flexible(flex: 1, child: buildImage(context, 7)),
                  Flexible(flex: 1, child: buildImage(context, 8)),
                ],
              ),
            ),
          ],
        ));
  }

  Widget choosemode(context) {
    switch (images.length) {
      case 1:
        return oneimage(context);
        //Return full image size
        break;
      case 2:
        return twoimages(context);
        //Return 2 image with(2:3)width/height
        //Total 4:6 width/height
        break;
      case 3:
        return threeimages(context);
        //Return 1 big image 3:2
        //Return 2 image with 9:16
        break;
      case 4:
        return fourimages(context);
        break;
      case 5:
        return fiveimages(context);
        break;
      case 6:
        return siximages(context);
        break;
      case 7:
        return sevenimages(context);
        break;
      case 8:
        return eightimages(context);
        break;
      case 9:
        return nineimages(context);
        break;
      default:
        return SizedBox(
          height: 0,
          width: 0,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    if (images != null) {
      return choosemode(context);
    } else {
      return SizedBox(
        height: 0,
        width: 0,
      );
    }
    /*
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            twoimages(context),
            Container(
              color: Colors.blue,
              child: SizedBox(
                height: 20,
                width: double.infinity,
              ),
            ),
            threeimages(context),
            Container(
              color: Colors.blue,
              child: SizedBox(
                height: 20,
                width: double.infinity,
              ),
            ),
            fourimages(context),
            Container(
              color: Colors.blue,
              child: SizedBox(
                height: 20,
                width: double.infinity,
              ),
            ),
            fiveimages(context),
            Container(
              color: Colors.blue,
              child: SizedBox(
                height: 20,
                width: double.infinity,
              ),
            ),
            siximages(context),
            Container(
              color: Colors.blue,
              child: SizedBox(
                height: 20,
                width: double.infinity,
              ),
            ),
            sevenimages(context),
            Container(
              color: Colors.blue,
              child: SizedBox(
                height: 20,
                width: double.infinity,
              ),
            ),
            eightimages(context),
            Container(
              color: Colors.blue,
              child: SizedBox(
                height: 20,
                width: double.infinity,
              ),
            ),
            nineimages(context),
          ],
        ),
      ),
    );
    */
  }
}
