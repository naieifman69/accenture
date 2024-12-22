import 'package:accenture/Screens/Main/MainScreen.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../../Provider/LoginProvider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
final idController = TextEditingController();
String ID = '';

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    idController.addListener(() { ID = idController.text;});

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color(0xffFFEDEF),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
              ),


              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  const SizedBox(height: 20,),

                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color(0xffFFEDEF)
                    ),
                    child: Image.asset('assets/device-mobile.png',color: Colors.redAccent,scale: 0.7,),
                  ),

                  const SizedBox(height: 20,),

                  Text('WELCOME', style: TextStyle(color: Colors.redAccent,fontSize: 34)),


                  const SizedBox(height: 20,),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: TextFormField(
                      controller: idController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // Allows only digits
                        LengthLimitingTextInputFormatter(10),  // Limits input to 10 characters
                      ],
                      decoration: const InputDecoration.collapsed(hintText: "Mobile",hintStyle: TextStyle(fontSize: 14,letterSpacing: 0.1,color: Color(0xff5c6672))),

                    ),
                  ),

                  const SizedBox(height: 20,),

                  GestureDetector(
                    onTap: () async {
                      /*final SharedPreferences sharedprefrences = await SharedPreferences.getInstance();
                      sharedprefrences.setString('number', idController.text);

                      Provider.of<LoginProvider>(context, listen: false).updateNumber(idController.text);*/

                      final loginProvider = Provider.of<LoginProvider>(context, listen: false);

                      loginProvider.updateNumber(idController.text);

                      if(idController.text.isNotEmpty && idController.text.length == 10){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return MainScreen();
                        }));

                      }
                      else if(idController.text.isEmpty){
                        Fluttertoast.showToast(
                            msg: "Please enter mobile number",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.white70,
                            textColor: Colors.black,
                            fontSize: 16.0
                        );
                      }

                      else if(idController.text.length !=10){
                        Fluttertoast.showToast(
                            msg: "Must be Malaysian Number",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.white70,
                            textColor: Colors.black,
                            fontSize: 16.0
                        );
                      }


                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text('Login',style: TextStyle(color: Colors.yellow,fontSize: 20),),
                      ),

                    ),
                  ),

                  const SizedBox(height: 20,),


                ],
              ),

            ),
          ),

        ),
      ),
    );
  }
}
