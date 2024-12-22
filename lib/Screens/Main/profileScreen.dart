import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Provider/LoginProvider.dart';
import '../Authentication/Login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override


  void logout(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    loginProvider.updateNumber(''); // Clear provider data

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('number'); // Clear saved data

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }



  Widget build(BuildContext context) {
    
    final loginProvider = Provider.of<LoginProvider>(context);


    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.blue[200],
                ),
                child: Image.asset("assets/user.png",color: Colors.blue,),
              ),

              const SizedBox( height: 30,),

              Text('Mobile : ${loginProvider.number}'),

              const SizedBox( height: 20,),


              GestureDetector(
                onTap: (){
                  return logout(context);
                },
                child: Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Center(child: Text('Logout',style: TextStyle(color: Colors.yellowAccent),)),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
