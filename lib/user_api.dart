import 'dart:convert';

import 'package:flutter/material.dart';
import 'Model/UsersModel.dart';
import 'package:http/http.dart' as http;
class UsersApi extends StatefulWidget {
  const UsersApi({Key? key}) : super(key: key);

  @override
  State<UsersApi> createState() => _UsersApiState();
}

class _UsersApiState extends State<UsersApi> {
  List<UsersModel> userList=[];
  Future<List<UsersModel>> getUsers() async{
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200)
    {
      for(Map i in data){
        userList.add(UsersModel.fromJson(i));
      }
      return userList;
    }
    else{
      return userList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUsers(),
                builder: (context,AsyncSnapshot<List<UsersModel>>snapshot){
                  if(!snapshot.hasData)
                  {
                    return CircularProgressIndicator();
                  }
                  else{
                    return ListView.builder(
                      itemCount: userList.length,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Card(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  ReusableRow(title: 'Name', description: snapshot.data![index].name.toString()),
                                  ReusableRow(title: 'Email', description: snapshot.data![index].email.toString()),
                                  ReusableRow(title: 'Street', description: snapshot.data![index].address!.street.toString()),
                                  ReusableRow(title: 'City', description: snapshot.data![index].address!.city.toString()),
                                  ReusableRow(title: 'Company', description: snapshot.data![index].company!.name.toString()),
                                ],
                              ),
                            ),
                          );
                        });
                  }

                }),
          )
        ],
      ),
    );
  }
}
class ReusableRow extends StatelessWidget {
  String title,description;
  ReusableRow({required this.title,required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(description,),
        ],
      ),
    );
  }
}