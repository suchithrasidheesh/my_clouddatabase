import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../modelProvider/Movie.dart';

final List<Movie> data=List.generate(
    100, (index) => Movie(title: 'Movies $index',time: '${Random().nextInt(100)+60}minutes'));

class MovieProvider with ChangeNotifier{
  final List<Movie>movieHome=data;

  List<Movie>get movies=>movieHome;//Retrieve all the movies

  final List<Movie>wishlist=[];//fetch list from wishlist

  List<Movie>get wishmovie=>wishlist;

  void addToList(Movie movie){
    wishlist.add(movie);
    notifyListeners();
  }

  void removeFromList(Movie movie){
    wishlist.remove(movie);
    notifyListeners();
  }

}