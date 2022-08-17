import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;
class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  final _picker=ImagePicker();
  bool showSpinner=false;
  Future getImage()async{
    final pickedimage=await _picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    if(pickedimage!=null){
      image=File(pickedimage.path);
      setState((){

      });
    }
    else{
      print('image not selected');
    }
  }
  Future<void> uploadImage()async {
    setState((){
      showSpinner=true;
    });
    var stream=new http.ByteStream(image!.openRead());
    stream.cast();
    var length=await image!.length();
    var uri=Uri.parse('https://fakestoreapi.com/products');
    var request=new http.MultipartRequest('POST',uri);
    request.fields['title']="Static title";
    var multiport=new http.MultipartFile('image', stream, length);
    request.files.add(multiport);
    var response=await request.send();
    if(response.statusCode==200){
      setState((){
        showSpinner=false;
      });
      print('Image Uploaded succesfully');
    }
    else{
      setState((){
        showSpinner=false;
      });
      print('Image upload failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                child: image==null?Center(child: Text('Pick an image'),)
                :Container(
                  child: Center(
                    child: Image.file(
                      File(image!.path).absolute,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,

                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 80,),
            GestureDetector(
              onTap: (){
                uploadImage();
              },
              child: Container(
                height: 50,
                width: 200,
                child: Center(child: Text('Upload'),),
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
