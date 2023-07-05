
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_one/ui/auth/login_screen.dart';
import 'package:firebase_one/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../widgets/round_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailControler = TextEditingController();
  final passswordControler = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailControler.dispose;
    passswordControler.dispose();
  }

  void signup(){
    setState(() {
                  loading =true;
                });
              
                _auth.createUserWithEmailAndPassword(
                  email: emailControler.text.toString(),
                  password: passswordControler.text.toString(),
                  ).then((value){
                    
                  setState(() {
                  loading =false;
                  });
                    Utils().toastMessage('Successfully Added');
                  }).onError((error, stackTrace){
                    
                    setState(() {
                    loading =false;
                    });
                    Utils().toastMessage(error.toString());
                  });
              
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: Text('Sign Up'),
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
              title: 'Sign Up',
              loading: loading,
              onTap: (){
                if(_formKey.currentState!.validate()){
                signup();
                }
            },
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                }, child: Text('Login'))
              ],
            ),
          ],
        ),
      ),
    );
  }

}