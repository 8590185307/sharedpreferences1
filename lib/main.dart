import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs =await SharedPreferences.getInstance();
  var email=prefs.getString("email");
  print(email);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: email==null?Login():Home(),));
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
  return  Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(

              onPressed: () async {
                SharedPreferences pref =await SharedPreferences.getInstance();
                pref.setString("email", "useremail@gmail.com");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                  return Home();
                }));
              },
              child: const Text("Login",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var email="";
  @override
void initState()  {
    // TODO: implement initState
    super.initState();
  getmail();
  }
  Future<void> getmail() async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
  setState(() {
    email=prefs.getString("email")!;
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"),),
      body: Center(
        child: Column(
          children: [
            Text('${email}'),
            ElevatedButton(

              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove("email");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                  return Login();
                }));
              },
              child: Text("Logout",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
