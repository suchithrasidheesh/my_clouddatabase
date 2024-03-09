import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBMZBUBWkRiAEwYdQIDoo2zkbzCHxGkb4w",
        appId: "1:604024428092:android:3f7b4fd41630941dd09539",
        messagingSenderId:'',
        projectId:"mynewclouddb-2312c",
        storageBucket:"mynewclouddb-2312c.appspot.com" ,
      ));
  runApp(MaterialApp(home:myCloudDb(),));
}

class myCloudDb extends StatefulWidget{
  @override
  State<myCloudDb> createState() => _myCloudDbState();
}

class _myCloudDbState extends State<myCloudDb> {
  var name_cntrl=TextEditingController();
  var email_cntrl=TextEditingController();
  late CollectionReference userCollection;
  @override
  void initState() {
    userCollection=FirebaseFirestore.instance.collection('users');
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height:20,),
          Center(child: Text('Login Page',style:TextStyle(fontSize: 20,fontWeight:FontWeight.bold),)),
          SizedBox(height:20,),
          TextField(
            controller: name_cntrl,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Name'
            ),
          ),
          SizedBox(height:20,),
          TextField(
            controller: email_cntrl,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Email'
            ),
          ),
          SizedBox(height:20,),
          ElevatedButton(onPressed:(){
            addUser();
          }, child:Text('Add User')),
          SizedBox(height:20,),
          StreamBuilder<QuerySnapshot>(
              stream:getUser() ,
              builder: (context,snapshot) {
                if(snapshot.hasError){
                  return Text('Error ${snapshot.error}');
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return CircularProgressIndicator();
                }
                final users=snapshot.data!.docs;
                return Expanded(
                  child:ListView.builder(
                    itemBuilder:(context,index){
                      final user=users[index];
                      final userid=user.id;
                      final username=user['name'];
                      final useremail=user['email'];
                      return ListTile(
                        title: Text('$username'),
                        subtitle: Text('$useremail'),
                        trailing: Wrap(
                          children: [
                            IconButton(onPressed: (){
                              editUser(userid,username,useremail);
                            }, icon:Icon(Icons.edit)),
                            IconButton(onPressed: (){
                              deleteUser(userid);
                            }, icon:Icon(Icons.delete))
                          ],
                        ),

                      );
                    },itemCount:users.length,),
                );

              }
          )
        ],
      ),
    );
  }

  Future<void>addUser()async {
    return userCollection.add({
      'name':name_cntrl.text,
      'email':email_cntrl.text,
    }).then((value){
      print('User added Successfully');
      name_cntrl.clear();
      email_cntrl.clear();
    }).catchError((error){
      print('Failed to add user $error');
    });
  }

  Stream<QuerySnapshot>getUser() {
    return userCollection.snapshots();
  }

  Future editUser(var id,String name,String email){
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 5,
        builder: (context){
          var new_namecntrollr=TextEditingController();
          var new_emailcntrollr=TextEditingController();
          new_namecntrollr.text=name;
          new_emailcntrollr.text=email;
          return Container(
            padding: EdgeInsets.only(
              left: 15,right: 15,top: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom+100,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10,),
                Center(child: Text('Update User')),
                SizedBox(height: 10,),
                TextField(
                  controller: new_namecntrollr,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: 'Enter name'
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller:new_emailcntrollr,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: 'Enter password'
                  ),
                ),
                TextButton(onPressed:(){
                  updateUser(id,new_namecntrollr.text,new_emailcntrollr.text).then((value){
                    Navigator.pop(context);
                  });
                }, child:Text('Updateuser'))

              ],
            ),
          );

        });

  }

  updateUser(id, String newname, String newemail) {
    return userCollection.doc(id).update({
      'name':newname,'email':newemail
    }).then((value){
      print('User Updated successfully');
    }).catchError((Error) {
      print('User dataUpdated Failed $Error');
    });

  }

  Future<void> deleteUser(var id) {
    return userCollection.doc(id).delete().then((value){
      print('User deleted Successfully');
    }).catchError((Error){
      print('User deletion Failed $Error');
    });
  }

}