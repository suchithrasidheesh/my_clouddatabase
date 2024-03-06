import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_clouddatabase/Provider/MovieProvider.dart';
import 'package:provider/provider.dart';

class WishList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var wishlist=context.watch<MovieProvider>().wishmovie;
    return Scaffold(
      appBar: AppBar(
        title: Text('My WishList (${wishlist.length})'),
      ),
      body: ListView.builder(itemBuilder: (context,index){
        final movie=wishlist[index];
        return Card(
          key: ValueKey(movie.title),
          child: ListTile(
            title: Text(movie.title),
            trailing: TextButton(
                onPressed:(){
                  context.read<MovieProvider>().removeFromList(movie);
                },
                child: Text('REMOVE')),
          ),
        );
      },itemCount: wishlist.length,),
    );
  }

}