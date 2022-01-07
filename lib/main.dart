import 'package:flutter/material.dart';
import 'api_provider/api_services.dart';
import 'model/user_data/users_data_response.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "User List",
      home: UsersDetails(title:"User List"),
    );
  }
}

class UsersDetails extends StatefulWidget {
  const UsersDetails({Key? key,this.title}) : super(key: key);
  final String? title;

  @override
  _UsersDetailsState createState() => _UsersDetailsState();
}

class _UsersDetailsState extends State<UsersDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchUsersData(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context,int index ){
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(snapshot.data[index]['picture']['large'])),
                            title: Text((snapshot.data[index]['name']['first'])),
                            subtitle: Text((snapshot.data[index]['location']['city'])),
                            trailing: Text((snapshot.data[index]['dob']['age'].toString())),
                          ),
                      ],
                    ),
                  );
                }
            );
          }
          else if (snapshot.hasError){
            return Text('Error: ${snapshot.error}');
          }
           else{
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }
}

