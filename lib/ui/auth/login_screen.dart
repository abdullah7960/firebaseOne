
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_one/ui/auth/signup_screen.dart';
import 'package:firebase_one/ui/posts/post_screen.dart';
import 'package:firebase_one/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailControler = TextEditingController();
  final passswordControler = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool loading = false;

  void login(){
    setState(() {
      loading=true;
    });
    _auth.signInWithEmailAndPassword(
      email: emailControler.text, 
      password: passswordControler.text).then((value) {
        Utils().toastMessage('SuccessFully Login');
        setState(() {
        loading=false;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
      }).onError((error, stackTrace) {
        setState(() {
        loading=false;
        });
        Utils().toastMessage(error.toString());
      });
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailControler.dispose;
    passswordControler.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Login'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                
                key: _formKey,
                child: Column(
                  children: [
                TextFormField(
                keyboardType: TextInputType.text,
                controller: emailControler,
                decoration: const InputDecoration(
                  hintText: 'email',
                  //helperText: 'enter e mail e.g abdullah',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Enter Email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                controller: passswordControler,
                decoration: const InputDecoration(
                  hintText: 'passsword',
                  //helperText: 'enter e mail e.g abdullah',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Enter Password';
                  }
                  return null;
                },
              ),
                  ],
                ),
               ),
              const SizedBox(height: 50,),
              RoundButton(
                loading: loading,
                title: 'Login',onTap: (){
                if(_formKey.currentState!.validate()){
                  login();
                }
              },
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dont have an account?'),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                  }, child: Text('Sign up'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}