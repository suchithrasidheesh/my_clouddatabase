import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/MovieProvider.dart';
import 'Wishlist.dart';

void main(){
  runApp(ChangeNotifierProvider(
      create:(_)=>MovieProvider(),
      child: MaterialApp(home: Home(),),
  ));
}

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    var movies=context.watch<MovieProvider>().movies;
    var movielist=context.watch<MovieProvider>().wishmovie;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            ElevatedButton.icon(
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder:(context)=>WishList()));
                },
                icon:Icon(Icons.favorite),
                label: Text('Go To WishList ${movielist.length}')
            ),
            SizedBox(height: 20,),
            Expanded(
                child: Center(
                  child: Padding(padding:EdgeInsets.all(8.0),
                    child: ListView.builder(itemBuilder:(context,index){
                      var movie=movies[index];
                      return Card(
                        key: ValueKey(movie.title),
                        child: ListTile(
                          title: Text(movie.title),
                          subtitle: Text(movie.time??'No time'),
                          trailing: IconButton(
                              color: movielist.contains(movie)?Colors.red:Colors.blue,
                              onPressed: (){
                                if(!movielist.contains(movie)){
                                  context.read<MovieProvider>().addToList(movie);
                                }else{
                                  context.read<MovieProvider>().removeFromList(movie);
                                }
                              },
                              icon: Icon(Icons.favorite)),
                        ),
                      );
                    },itemCount:movies.length,),
                  ),
                ))
          ],
        ),
      ),

    );
  }

}