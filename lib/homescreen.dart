import 'dart:convert';
import 'Model/photos_model.dart';
import 'package:flutter/material.dart';
import 'Model/PostsModel.dart';
import 'Model/UsersModel.dart';
import 'package:http/http.dart' as http;
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postList=[];
  Future<List<PostsModel>> getPostApi() async
  {
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200)
      {
          for(Map i in data)
            {
              postList.add(PostsModel.fromJson(i));
            }
          return postList;
      }
    else
      {
          return postList;
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('RestApi\'s Demo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
                builder: (context,snapshot){
                if(!snapshot.hasData)
                  {
                    return const Center(child: Text('Loading'));
                  }
                else
                  {
                    return ListView.builder(
                      itemCount: postList.length,
                        itemBuilder: (context,index){
                          return Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('User-Id',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                SizedBox(height: 8,),
                                Text(postList[index].userId.toString()),
                                Text('Id',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                SizedBox(height: 8,),
                                Text(postList[index].id.toString()),
                                Text('Title',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                SizedBox(height: 8,),
                                Text(postList[index].title.toString()),
                                SizedBox(height: 8,),
                                Text('Body',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                Text(postList[index].body.toString()),
                                SizedBox(height: 13,),


                              ],
                            ),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class PhotosApi extends StatefulWidget {
  const PhotosApi({Key? key}) : super(key: key);

  @override
  State<PhotosApi> createState() => _PhotosApiState();
}

class _PhotosApiState extends State<PhotosApi> {
  List<PhotosModel> photoList=[];
  Future<List<PhotosModel>> getPhotos()async{
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200)
      {
        for(Map i in data)
          {
            PhotosModel photosModel=PhotosModel(id: i['id'], title: i['title'], url: i['url']);
            photoList.add(photosModel);
          }
        return photoList;
      }
    else{
      return photoList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
                builder: (context,AsyncSnapshot<List<PhotosModel>> snapshot){
                  return ListView.builder(
                    itemCount: photoList.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data![index].url),
                      ),
                      subtitle: Text(snapshot.data![index].title),
                      title: Text(snapshot.data![index].id.toString()),
                    );
                  });
                }),
          )
        ],
      ),
    );
  }
}






