import 'package:flutter/material.dart';
import 'package:todo/routes/route_paths.dart';
import 'package:todo/view/screens/default_screen.dart';
import 'package:todo/view/screens/home_screen.dart';

class RouteNavigation{
  static Route generateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteName.homeRoute:return MaterialPageRoute(builder: (context)=>HomePage());
      default:return MaterialPageRoute(builder: (context)=>DefaultPage());
    }
  }
}