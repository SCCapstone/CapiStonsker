
import 'package:capi_stonsker/main.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/markers/locations.dart' as locs;
import 'package:firebase_core/firebase_core.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 2), vsync: this,
    );
    //Implement animation here
    _animation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller);
    
    super.initState();
    initializeLocationAndSave();
  }

  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void initializeLocationAndSave() async{

    await locs.getMarkers();
    await locs.getWish();
    await locs.getVis();


    Future.delayed(
        const Duration(seconds: 3),
            () =>
            Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyHomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Material(
        color: Colors.black,
        child: Center(child: Image.asset('assets/image/logo.PNG')),
      ),
    );
  }
}
